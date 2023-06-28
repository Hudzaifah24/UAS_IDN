<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    public function login()
    {
        return view('pages.profile.masuk');
    }

    public function authenticate(Request $request)
    {
        $credentials = $request->validate([
            'username' => 'required',
            'password' => 'required'
        ]);

        if (Auth::attempt(['username' => $credentials['username'], 'password' => $credentials['password'], 'active' => 1])) {
            $request->session()->regenerate();

            return redirect()->route('pilih.aplikasi');
        }

        return back()->with('username', 'Afwan, Kredensial tidak cocok dengan catatan kami.')->onlyInput('username');
    }

    public function logout(Request $req)
    {
        Auth::logout();

        request()->session()->invalidate();

        request()->session()->regenerateToken();

        return redirect()->route('masuk');
    }
}
