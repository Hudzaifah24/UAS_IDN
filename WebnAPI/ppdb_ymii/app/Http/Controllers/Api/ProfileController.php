<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProfileRequest;
use App\Models\User;
use App\Traits\ApiResponser;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class ProfileController extends Controller
{
    use ApiResponser;

    public function getProfile() {
        $user = Auth::user();

        if(!$user) {
            return $this->error('Gagal Menggugah Data');
        }

        return $this->success($user, 'Berhasil menggugah data', 200);
    }

    public function update(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:20',
            'username' => 'required|max:10|unique:users,username,'.Auth::user()->id,
            'nama_ayah' => 'nullable|string|max:20',
            'nama_ibu' => 'nullable|string|max:20',
            'no_tlp_ayah' => 'nullable|max:20',
            'no_tlp_ibu' => 'nullable|max:20',
            'email' => 'required|email',
            'alamat' => 'nullable',
        ]);

        if ($validator->fails()) {
            return $this->error($validator->errors());
        }

        $auth = Auth::user();

        $data = $request->all();

        $user = User::findOrFail($auth->id);

        $user->update($data);

        return $this->success($user, 'Berhasil Mengedit Data', 200);
    }
}
