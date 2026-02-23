<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

try {
    if (\App\Models\Setting::where('key', 'home_page_title')->count() === 0) {
        echo "Running seeders...\n";
        \Illuminate\Support\Facades\Artisan::call('db:seed', ['--force' => true]);
        echo "Seeding completed!\n";
    } else {
        echo "Database already seeded.\n";
    }
} catch (\Exception $e) {
    echo "Error during database initialization: " . $e->getMessage() . "\n";
    exit(1);
}
