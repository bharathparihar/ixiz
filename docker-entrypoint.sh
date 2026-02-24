#!/bin/sh
set -e

# FORCE Laravel to use PostgreSQL and clear any old cached config
echo "Initial cleanup..."
php artisan config:clear || true
php artisan cache:clear || true

# Parse DATABASE_URL if it exists (highly reliable for Render/Heroku)
if [ -n "$DATABASE_URL" ]; then
    echo "Parsing DATABASE_URL for DB configuration..."
    eval $(php -r '
        $url = parse_url(getenv("DATABASE_URL"));
        if (isset($url["host"])) echo "export DB_HOST=" . $url["host"] . "\n";
        if (isset($url["port"])) echo "export DB_PORT=" . $url["port"] . "\n";
        if (isset($url["path"])) echo "export DB_DATABASE=" . ltrim($url["path"], "/") . "\n";
        if (isset($url["user"])) echo "export DB_USERNAME=" . $url["user"] . "\n";
        if (isset($url["pass"])) echo "export DB_PASSWORD=" . $url["pass"] . "\n";
    ')
    export DB_CONNECTION=pgsql
    # Force SSL mode for production databases if not set
    if [ -z "$DB_SSLMODE" ]; then
        export DB_SSLMODE=require
    fi
fi

if [ -z "$APP_URL" ] && [ -n "$RENDER_EXTERNAL_URL" ]; then
    export APP_URL="$RENDER_EXTERNAL_URL"
    echo "Set APP_URL from RENDER_EXTERNAL_URL: $APP_URL"
fi

if [ -n "$APP_URL" ] && ! echo "$APP_URL" | grep -q "://"; then
    export APP_URL="https://$APP_URL"
    echo "Fixed APP_URL: $APP_URL"
fi

echo "Forcing DB_CONNECTION: $DB_CONNECTION"
echo "Current DB_HOST: $DB_HOST"
echo "Current DB_DATABASE: $DB_DATABASE"

# Wait for DB to wake up
echo "Waiting for database connection..."
max_retries=10
count=0
while [ $count -lt $max_retries ]; do
    if php artisan db:show > /dev/null 2>&1 || php artisan migrate:status > /dev/null 2>&1; then
        echo "Database is ready!"
        break
    fi
    echo "Database not ready yet... waiting 5s (Attempt $((count+1))/$max_retries)"
    sleep 5
    count=$((count+1))
done

php -d memory_limit=-1 artisan migrate --force

# Robust check if database needs seeding (check for users)
if php artisan db:show > /dev/null 2>&1; then
    USER_COUNT=$(php artisan tinker --execute="echo \App\Models\User::count();" 2>/dev/null | grep -oE '[0-9]+' | tail -n 1)
    if [ -z "$USER_COUNT" ] || [ "$USER_COUNT" = "0" ]; then
        echo "Database appears empty (User count: $USER_COUNT). Seeding..."
        php artisan db:seed --force
    else
        echo "Database already has $USER_COUNT users. Skipping seed."
    fi
fi

# Allow forced credential reset via environment variable
if [ "$FORCE_UPDATE_CREDENTIALS" = "true" ]; then
    echo "FORCE_UPDATE_CREDENTIALS is true. Updating admin users..."
    php -d memory_limit=-1 artisan db:seed --class=DefaultUserSeeder --force
    php -d memory_limit=-1 artisan db:seed --class=DefaultRoleSeeder --force
fi

# Now run optimizations at runtime
echo "Running optimizations..."
php artisan package:discover --ansi
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Mark as installed if database is ready
touch /var/www/html/storage/installed

# Ensure permissions are correct for Apache after Artisan might have created files as root
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Start Apache
echo "Starting Apache..."
exec apache2-foreground
