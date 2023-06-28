<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Application extends Model
{
    use HasFactory;

    protected $table = 'applications';

    protected $fillable = [
        'akte_kelahiran',
        'kartu_keluarga',
        'ktp_ayah',
        'ktp_ibu',
        'ijazah_terakhir',
        'budget',
        'akte_kelahiran_time',
        'kartu_keluarga_time',
        'ktp_ayah_time',
        'ktp_ibu_time',
        'ijazah_terakhir_time',
        'budget_time',
        'bukti_pembayaran',
        'status',
        'user_id',
    ];
}
