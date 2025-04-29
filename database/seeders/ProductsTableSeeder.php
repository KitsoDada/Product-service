<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Seeder;

class ProductsTableSeeder extends Seeder
{
    public function run()
    {
        Product::create([
            'name' => 'Premium Coffee',
            'description' => 'Finest quality coffee beans',
            'price' => 12.99,
            'stock' => 100,
            'category' => 'Beverages'
        ]);

        Product::create([
            'name' => 'Organic Tea',
            'description' => 'Natural herbal tea',
            'price' => 8.99,
            'stock' => 150,
            'category' => 'Beverages'
        ]);

        // Add more sample products as needed
    }
}