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
        Schema::create('applications', function (Blueprint $table) {
            $table->id();
            $table->text('akte_kelahiran')->nullable();
            $table->text('kartu_keluarga')->nullable();
            $table->text('ktp_ayah')->nullable();
            $table->text('ktp_ibu')->nullable();
            $table->text('ijazah_terakhir')->nullable();
            $table->bigInteger('budget')->nullable();
            $table->text('bukti_pembayaran')->nullable();
            $table->enum('status', ['pp', 'pondok']);
            $table->foreignId('user_id');
            $table->time('akte_kelahiran_time')->nullable();
            $table->time('kartu_keluarga_time')->nullable();
            $table->time('ktp_ayah_time')->nullable();
            $table->time('ktp_ibu_time')->nullable();
            $table->time('ijazah_terakhir_time')->nullable();
            $table->time('budget_time')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('applications');
    }
};
