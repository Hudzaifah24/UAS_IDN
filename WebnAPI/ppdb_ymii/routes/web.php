<?php

use App\Http\Controllers\ActivationController;
use App\Http\Controllers\ApplicationController;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\PendaftarController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\SocialController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::middleware('auth')->group(function () {
    Route::get('/', function() {
        return redirect()->route('dashboard');
    });
    Route::middleware('Admin')->group(function() {
        Route::resource('/pengguna', UserController::class)->except('create', "store");
        Route::resource('/pendaftar', PendaftarController::class);
        Route::get('aktifasi-edit/{id}', [ActivationController::class, 'activasi_edit'])->name('aktifasi.edit');
    });
    Route::middleware('ActiveApplication')->group(function() {
        Route::get('/pilih-aplikasi', [ApplicationController::class, 'pilih_aplikasi'])->name('pilih.aplikasi');
        Route::post('/pilih-aplikasi-action', [ApplicationController::class, 'pilih_aplikasi_action'])->name('pilih.aplikasi.action');
    });

    Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');
    Route::resource('social', SocialController::class);
    Route::post('/logout', [LoginController::class, 'logout'])->name('logout');
    Route::get('/profile', [ProfileController::class, 'index'])->name('profile');
    Route::get('/profile/edit/{username}', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::put('/profile/update/{username}', [ProfileController::class, 'update'])->name('profile.update');
    Route::put('/photo/profile/{username}', [ProfileController::class, 'photo_profile'])->name('photo.profile');

    // Payment
    Route::get('payment/{username}', [ApplicationController::class, 'pay'])->name('pay');
    Route::post('payment/proses/{username}', [ApplicationController::class, 'pay_proses'])->name('pay.proses');

    // Akte kelahiran
    Route::get('akte-kelahiran/{username}', [ApplicationController::class, 'ak'])->name('ak');
    Route::post('akte-kelahiran/proses/{username}', [ApplicationController::class, 'ak_proses'])->name('ak.proses');

    // Kartu Keluarga
    Route::get('kartu-keluarga/{username}', [ApplicationController::class, 'kk'])->name('kk');
    Route::post('kartu-keluarga/proses/{username}', [ApplicationController::class, 'kk_proses'])->name('kk.proses');

    // KTP Ayah
    Route::get('ktp-ayah/{username}', [ApplicationController::class, 'ka'])->name('ka');
    Route::post('ktp-ayah/proses/{username}', [ApplicationController::class, 'ka_proses'])->name('ka.proses');

    // KTP Ibu
    Route::get('ktp-ibu/{username}', [ApplicationController::class, 'ki'])->name('ki');
    Route::post('ktp-ibu/proses/{username}', [ApplicationController::class, 'ki_proses'])->name('ki.proses');

    // Ijazah Terakhir
    Route::get('ijazah-terakhir/{username}', [ApplicationController::class, 'it'])->name('it');
    Route::post('ijazah-terakhir/proses/{username}', [ApplicationController::class, 'it_proses'])->name('it.proses');

    // Download
    // Route::get('download/{file}/{category}', [ApplicationController::class, 'getDownload'])->name('download');
});


Route::middleware('guest')->group(function() {
    Route::post('/daftar-action', [UserController::class, 'store'])->name('daftar.action');
    Route::get('/daftar', [UserController::class, 'create'])->name('daftar');

    Route::get('/masuk', [LoginController::class, 'login'])->name('masuk');
    Route::post('/authenticate', [LoginController::class, 'authenticate'])->name('masuk.action');

    Route::get('/konfirmasi', [ActivationController::class, 'konfirmasi'])->name('konfirmasi');
    Route::post('/activation', [ActivationController::class, 'activation'])->name('activation');

    Route::get('/resend-input-email', [ActivationController::class, 'resend_input_email'])->name('resend.input.email');
    Route::post('/resend-action', [ActivationController::class, 'resend_action'])->name('resend.action');
    Route::get('/resend-success', [ActivationController::class, 'resend_success'])->name('resend.success');
    Route::get('/term', function () {
        return view('pages.profile.terms');
    });
});




