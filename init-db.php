<?php

require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

/**
 * init-db.php
 * This script ensures the database has initial data on Render.
 * It checks for a core setting to determine if seeding is needed.
 */

try {
    // We check for 'home_page_title' which is a core setting created by HomePageSeeder.
    // If it's missing, the database is likely empty.
    $settingExists = \Illuminate\Support\Facades\Schema::hasTable('settings') && 
                     \App\Models\Setting::where('key', 'home_page_title')->exists();

    if (!$settingExists) {
        echo "[INIT] Database settings missing. Starting full seeder...\n";
        
        // This runs the DatabaseSeeder class which calls all specific seeders.
        $exitCode = \Illuminate\Support\Facades\Artisan::call('db:seed', ['--force' => true]);
        
        if ($exitCode === 0) {
            echo "[INIT] Seeding successfully completed.\n";
        } else {
            echo "[INIT] Seeding failed with exit code: $exitCode\n";
            echo \Illuminate\Support\Facades\Artisan::output();
        }
    } else {
        echo "[INIT] Database already seeded. Skipping.\n";
    }
} catch (\Exception $e) {
    echo "[INIT] Error during database check: " . $e->getMessage() . "\n";
    // We don't exit with 1 because we want Apache to try starting anyway.
}
