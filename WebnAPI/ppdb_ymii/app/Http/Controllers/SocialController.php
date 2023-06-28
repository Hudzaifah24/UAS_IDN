<?php

namespace App\Http\Controllers;

use App\Http\Requests\SocialRequest;
use Illuminate\Http\Request;
use App\Models\Social;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class SocialController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(SocialRequest $request)
    {
        $data = $request->all();

        $data['user_id'] = Auth::user()->id;

        Social::create($data);

        return redirect()->back();
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(SocialRequest $request, string $username)
    {
        $data = $request->all();

        $user = User::where('username', $username)->first();

        $social = Social::where('user_id', $user->id)->first();

        $social->update($data);

        return redirect()->back();
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
