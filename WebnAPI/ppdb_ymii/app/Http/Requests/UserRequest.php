<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UserRequest extends FormRequest
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
            'username' => 'required|max:10|unique:users',
            'nama_ayah' => 'required|string|max:20',
            'nama_ibu' => 'required|string|max:20',
            'email' => 'required|email',
            'password' => 'required|confirmed|min:8|max:20',
            'password_confirmation' => 'required'
        ];
    }
}
