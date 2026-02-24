#!/bin/bash
# start.sh

# Bypass the installer entirely
echo "[START] Bypassing installer..."
touch storage/installed

# Ensure key directories exist and have correct permissions
echo "[START] Setting directory permissions..."
mkdir -p storage/app/public storage/framework/cache storage/framework/sessions storage/framework/views storage/logs bootstrap/cache public/uploads
chown -R www-data:www-data storage bootstrap/cache public/uploads
chmod -R 775 storage bootstrap/cache public/uploads

# Optimize Laravel for production
echo "[START] Optimizing Laravel performance..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Run migrations (safe for production)
echo "[START] Ensuring database is up to date..."
php artisan migrate --force

# Run seeders precisely once if missing essential settings
echo "[START] Checking database initialization..."
php init-db.php || true

# Start Apache in the foreground
echo "[START] Launching Apache..."
apache2-foreground
