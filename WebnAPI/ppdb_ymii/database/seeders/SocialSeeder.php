<?php

namespace Database\Seeders;

use App\Models\Social;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class SocialSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Social::truncate();

        Social::create([
            'instagram' => 'https://instagram/nga_woer',
            'twitter' => 'https://twitter/hudzef',
            'user_id' => 1,
        ]);

        Social::create([
            'instagram' => 'https://instagram/nga_woer',
            'twitter' => 'https://twitter/hudzef',
            'user_id' => 3,
        ]);
    }
}
