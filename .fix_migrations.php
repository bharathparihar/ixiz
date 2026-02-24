<?php
$files = glob(__DIR__ . "/database/migrations/*.php");
foreach ($files as $f) {
    if (basename($f) == "2023_11_24_095550_add_paystack_key_and_paystack_secret_column_to_table_name.php") continue;
    $c = file_get_contents($f);
    $new_c = preg_replace("/('key'\s*=>\s*'[^']+'),?\s*]/m", "$1,\n            'value' => ''\n        ]", $c);
    
    // Also handle format like Setting::create(['key' => 'something']); if any
    $new_c2 = preg_replace("/\['key'\s*=>\s*'([^']+)'\]/", "['key' => '$1', 'value' => '']", $new_c);

    if ($c !== $new_c2) {
        file_put_contents($f, $new_c2);
        echo "Updated " . basename($f) . "\n";
    }
}
