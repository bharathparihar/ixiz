#!/bin/bash
# start.sh
php artisan route:clear
php artisan config:clear
php artisan cache:clear

# Run migrations (safe for production as it won't overwrite data unless there are new tables)
php artisan migrate --force

# Run seeders precisely once if missing essential settings
php -r "require 'vendor/autoload.php'; \$app = require_once 'bootstrap/app.php'; \$kernel = \$app->make(Illuminate\Contracts\Console\Kernel::class); \$kernel->bootstrap(); if (\App\Models\Setting::where('key', 'home_page_title')->count() == 0) { echo 'Running db:seed... '; Artisan::call('db:seed', ['--force' => true]); echo 'Seeding complete.'; }" || true

# Start Apache in the foreground
apache2-foreground
