<?php

namespace App\Http\Controllers;

use App\Http\Requests\ProfileRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;

class ProfileController extends Controller
{
    public function index()
    {
        $auth = Auth::user()->id;

        $user = User::with(['Social', 'Application'])->findOrFail($auth);

        return view('pages.profile', [
            'user' => $user
        ]);
    }

    public function edit(string $username)
    {
        $user = User::where('username', $username)->first();

        if (Auth::user()->role == 'peserta') {
            if ($username != Auth::user()->username) {
                return redirect()->back();
            }
        }

        return view('pages.profile.edit', [
            'user' => $user
        ]);
    }

    public function update(ProfileRequest $request, string $username)
    {
        $data = $request->all();

        $user = User::where('username', $username)->first();

        $user->update($data);

        return redirect()->back();
    }

    public function photo_profile(Request $request, $username)
    {
        $request->validate([
            'photo' => 'required|image|mimes:png,jpg,jpeg',
        ]);

        $file = $request->file('photo');

        $user = User::where('username', $username)->first();

        // if (File::exists(public_path('assets/img/profile/'. $user->photo))) {
        //     File::delete(public_path(). '/assets/img/profile/'.$user->photo);
        // }

        // hosting
        if (File::exists(public_path('/../../assets/img/profile/'. $user->photo))) {
            File::delete(public_path('/../../assets/img/profile/'. $user->photo));
        }

        $name_file = time().'.'.$file->getClientOriginalExtension();

        // $file->move(public_path('assets/img/profile'), $name_file);

        // hosting
        $file->move(public_path('/../../public_html/assets/img/profile'), $name_file);

        $user->update([
            'photo' => $name_file,
        ]);

        return redirect()->back();
    }
}
