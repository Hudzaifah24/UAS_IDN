<?php

namespace App\Http\Controllers;

use App\Mail\Konfirmasi_akun;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

class ActivationController extends Controller
{
    public function konfirmasi()
    {
        return view('pages.profile.konfirmasi');
    }

    public function activation(Request $req)
    {
        $email = $req->email;
        $token = $req->token;
        $un = $req->username;
        $user = User::where('email', $email)->where('username', $un)->first();

        if ($user) {
            if ($user->token == $token) {
                $user->update([
                    'active' => 1
                ]);
                return redirect()->route('masuk');
            } else {
                return redirect()->back()->with('errorToken', 'Afwan, Token salah, silahkan coba lagi.');
            }
        } else {
            return redirect()->back()->with('errorEmail', 'Afwan, Akun tidak sesuai dalam catatan kami.');
        }
    }

    public function resend_input_email()
    {
        return view('pages.profile.resend_input_email');
    }

    public function resend_action(Request $req)
    {
        $email = $req->email;
        $un = $req->username;

        $user = User::where('email', $email)->where('username', $un)->first();


        if ($user) {
            if ($user->active == 0) {
                $user->update([
                    'token' => rand(111111, 999999),
                ]);
                Mail::to($email)->send(new Konfirmasi_akun($user));
                return redirect()->route('resend.success');
            } else {
                return redirect()->back()->with('error', 'Afwan, Akun anda sudah terkonfirmasi / sudah aktif.');
            }
        } else {
            return redirect()->back()->with('error', 'Afwan, Peserta tidak terdaftar.');
        }
    }

    public function resend_success()
    {
        return view('pages.profile.resend_success');
    }

    // Admin
    public function activasi_edit($id)
    {
        $user = User::findOrFail($id);
        if ($user->active == 1) {
            $user->update([
                'active' => 0
            ]);
        } else {
            $user->update([
                'active' => 1
            ]);
        }

        return redirect()->back();
    }
}
