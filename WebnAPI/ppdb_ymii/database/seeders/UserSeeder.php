<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::truncate();

        User::create([
            'name' => 'ADMIN',
            'username' => 'admin',
            'nama_ayah' => 'abu admin',
            'nama_ibu' => 'ummu admin',
            'email' => 'mutiaraihsanpondokbelajar@gmail.com',
            'role' => 'admin',
            'active' => 1,
            'token' => 912345,
            'password' => Hash::make('admin12345678'),
        ]);

        User::create([
            'name' => 'sari romlah',
            'username' => 'sariromlah',
            'nama_ayah' => 'dede sukendi',
            'nama_ibu' => 'sari romlah',
            'email' => 'sariromlah24@gmail.com',
            'role' => 'staff',
            'active' => 1,
            'token' => 678901,
            'password' => Hash::make('sari12345678'),
        ]);

        User::create([
            'name' => 'abdul aziz',
            'username' => 'abdulaziz',
            'nama_ayah' => 'dede sukendi',
            'nama_ibu' => 'sari romlah',
            'email' => 'abdulaziz@gmail.com',
            'role' => 'peserta',
            'active' => 0,
            'token' => 234567,
            'password' => Hash::make('12345678'),
        ]);
    }
}
