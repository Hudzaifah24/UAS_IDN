<?php

use App\Http\Controllers\Api\ApplicationController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\DashboardController;
use App\Http\Controllers\Api\ProfileController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });


Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);
Route::post('/activation', [AuthController::class, 'activation']);
Route::post('/resend', [AuthController::class, 'resend']);

Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('/logout', [AuthController::class, 'logout']);
    Route::post('/update/profile', [ProfileController::class, 'update']);
    Route::get('/get/profile', [ProfileController::class, 'getProfile']);
    Route::post('/pembayaran', [ApplicationController::class, 'pembayaran']);
    Route::post('/pilih/aplikasi', [ApplicationController::class, 'pilih_aplikasi']);
    Route::post('/documents', [ApplicationController::class, 'documents']);
    Route::get('/get-documents', [ApplicationController::class, 'getDocuments']);
    Route::get('/count/progress', [DashboardController::class, 'countProgress']);
    Route::get('cek', [AuthController::class, 'cek']);
});
