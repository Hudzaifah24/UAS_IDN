<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class ProfileRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array|string>
     */
    public function rules(): array
    {
        return [
            'name' => 'required|string|max:20',
            'username' => 'required|max:10|unique:users,username,'.Auth::user()->id,
            'nama_ayah' => 'nullable|string|max:20',
            'nama_ibu' => 'nullable|string|max:20',
            'no_tlp_ayah' => 'nullable|max:20',
            'no_tlp_ibu' => 'nullable|max:20',
            'email' => 'required|email',
            'alamat' => 'nullable',
        ];
    }
}
