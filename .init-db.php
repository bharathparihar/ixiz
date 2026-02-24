<?php

/**
 * init-db.php
 * This script ensures the database has initial data on Render.
 * It checks for core settings to determine if seeding is needed.
 */

require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Artisan;

try {
    // Check if settings table exists
    if (!Schema::hasTable('settings')) {
        echo "[INIT] Settings table not found. Skipping seeding check.\n";
        return;
    }

    // We check for 'home_page_title' which is a core setting created by HomePageSeeder.
    $settingExists = DB::table('settings')->where('key', 'home_page_title')->exists();

    if (!$settingExists) {
        echo "[INIT] Database settings missing. Starting full seeder...\n";
        
        // This runs the DatabaseSeeder class which calls all specific seeders.
        $exitCode = Artisan::call('db:seed', ['--force' => true]);
        
        if ($exitCode === 0) {
            echo "[INIT] Seeding successfully completed.\n";
        } else {
            echo "[INIT] Seeding failed with exit code: $exitCode\n";
            echo Artisan::output();
        }
    } else {
        echo "[INIT] Database already seeded. Skipping.\n";
    }
} catch (\Exception $e) {
    echo "[INIT] Error during database check: " . $e->getMessage() . "\n";
}
