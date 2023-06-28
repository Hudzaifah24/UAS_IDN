<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('username')->unique();
            $table->text('photo')->nullable();
            $table->string('email');
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->string('nama_ayah')->nullable();
            $table->string('nama_ibu')->nullable();
            $table->bigInteger('no_tlp_ayah')->nullable();
            $table->bigInteger('no_tlp_ibu')->nullable();
            $table->text('alamat')->nullable();
            $table->integer('token')->unique();
            $table->boolean('active')->default(0);
            $table->enum('role', ['admin', 'staff', 'peserta']);
            $table->rememberToken();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
