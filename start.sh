#!/bin/bash
# start.sh
php artisan route:clear
php artisan config:clear
php artisan cache:clear

# Run migrations (safe for production as it won't overwrite data unless there are new tables)
php artisan migrate --force

# Run seeders precisely once if missing essential settings
php init-db.php || true

# Start Apache in the foreground
apache2-foreground
