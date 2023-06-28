<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Traits\ApiResponser;
use App\Mail\Konfirmasi_akun;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    use ApiResponser;

    public function login(Request $request)
    {
        $credentials = Validator::make($request->all(), [
            'username' => 'required',
            'password' => 'required',
        ]);

        if ($credentials->fails()) {
            return $this->error($credentials->errors());
        }

        $user = User::with(['Application', 'Social'])->where('username', $request->username)->first();

        if (!$user) {
            return $this->error('Akun tidak ditemukan dicatatan kami.');
        }

        if (Hash::check($request->password, $user->password)) {
            if ($user->active == 1) {
                $token = $user->createToken($request->username, ['server:update'])->plainTextToken;

                $data = [
                    'token' => $token,
                    'token_type' => 'Bearer',
                    'user_data' => $user,
                ];

                return $this->success($data, 'Login Berhasil');
            } else {
                return $this->error('Akun user belum diaktifasi.');
            }
        }
        return $this->error('Akun tidak ditemukan dalam catatan kami.');
    }

    public function register(Request $request)
    {
        $data = $request->all();

        $valitator = Validator::make($request->all(), [
            'name' => 'required|string|max:30',
            'email' => 'required|email',
            'username' => 'required|max:30|unique:users,username',
            'password' => 'required|confirmed',
        ]);

        if ($valitator->fails()) {
            return $this->error($valitator->errors());
        }

        $data['role'] = "peserta";
        $data['token'] = rand(111111, 999999);
        $data['password'] = Hash::make($data['password']);

        $user = User::create($data);

        if($user) {
            Mail::to($user->email)->send(new Konfirmasi_akun($user));
        }

        return $this->success($user, 'Pendaftaran Berhasil', 200);
    }

    public function activation(Request $request)
    {
        $email = $request->email;
        $token = $request->token;
        $un = $request->username;
        $user = User::with(['Application', 'Social'])->where('email', $email)->where('username', $un)->first();

        if ($user) {
            if ($user->token == $token) {
                $user->update([
                    'active' => 1
                ]);
                $token = $user->createToken($un, ['server:create'])->plainTextToken;

                $data = [
                    'token' => $token,
                    'token_type' => 'Bearer',
                    'user_data' => $user,
                ];
                return $this->success($data, 'Akun berhasil dikonfirmasi.');
            } else {
                return $this->error('Token salah, silahkan coba lagi.');
            }
        } else {
            return $this->error('Akun tidak ditemukan dalam catatan kami.');
        }
    }

    public function resend(Request $request)
    {
        $email = $request->email;
        $un = $request->username;

        $data = User::where('email', $email)->where('username', $un)->first();

        if ($data) {
            if ($data->active == 0) {
                $data->update([
                    'token' => rand(111111, 999999),
                ]);
                Mail::to($email)->send(new Konfirmasi_akun($data));
                return $this->success($data, 'Berhasil mengirim email.');
            } else {
                return $this->error('Akun anda sudah terkonfirmasi / sudah aktif.');
            }
        } else {
            return $this->error('Peserta tidak terdaftar.');
        }
    }

    public function logout()
    {
        $data = Auth::user();

        $data->currentAccessToken()->delete();

        return $this->success($data, 'Berhasil Logout');
    }

    public function cek()
    {
        $data = Auth::user();

        if ($data) {
            return $this->success($data, 'User yang login telah berhasil didapatkan.', 200);
        }

        return $this->error('User yang login tidak didapatkan.');
    }
}
