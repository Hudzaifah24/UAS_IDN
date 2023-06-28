@extends('layouts.parent')

@section('title', 'Pengguna')

@section('content')
<div class="flex flex-wrap -mx-3">
    <div class="flex-none w-full max-w-full px-3">
      <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-soft-xl rounded-2xl bg-clip-border">
        <div class="p-6 pb-0 mb-0 bg-white border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
          <h6>Pengguna Tabel</h6>
        </div>
        <div class="flex-auto px-0 pt-0 pb-2">
          <div class="p-0 overflow-x-auto">
            <table class="items-center justify-center w-full mb-0 align-top border-gray-200 text-slate-500">
              <thead class="align-bottom">
                <tr>
                  <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-gray-200 shadow-none text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Nama</th>
                  <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-gray-200 shadow-none text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Status</th>
                  <th class="px-6 py-3 font-semibold capitalize align-middle bg-transparent border-b border-gray-200 border-solid shadow-none tracking-none whitespace-nowrap"></th>
                  <th class="px-6 py-3 font-semibold capitalize align-middle bg-transparent border-b border-gray-200 border-solid shadow-none tracking-none whitespace-nowrap"></th>
                </tr>
              </thead>
              <tbody>
                  @foreach ($users as $data)
                      <tr>
                          <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                              <div class="flex px-2 py-1">
                                  <div>
                                      <img src="{{ $data->photo ? asset('assets/img/profile/'. $data->photo) : asset('assets/img/pp.jpg') }}" class="inline-flex items-center justify-center mr-4 text-sm text-white transition-all duration-200 ease-soft-in-out h-9 w-9 rounded-xl" alt="user1" />
                                  </div>
                                  <div class="flex flex-col justify-center">
                                      <h6 class="mb-0 text-sm leading-normal">{{ $data->name }}</h6>
                                  </div>
                              </div>
                          </td>
                          <td class="p-2 text-center align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                <div class="flex flex-col justify-center">
                                    <h6 class="mb-0 text-sm leading-normal">{{ $data->role }}</h6>
                                </div>
                          </td>
                          <td class="p-2 text-center align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                                <div class="flex flex-col justify-center">
                                    <h6 class="mb-0 text-sm leading-normal {{ $data->active == 1 ? 'text-green-500' : 'text-red-500' }}">{{ $data->active == 1 ? 'Active' : 'Non Active' }}</h6>
                                </div>
                          </td>
                          <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap shadow-transparent">
                              @if ($data->active)
                                <a href="{{ route('aktifasi.edit', $data->id) }}" class="inline-block px-8 py-2 my-2 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-yellow-700 to-orange-500 hover:shadow-soft-2xl hover:scale-102">Non Active</a>
                              @else
                                <a href="{{ route('aktifasi.edit', $data->id) }}" class="inline-block px-8 py-2 my-2 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-slate-700 to-blue-500 hover:shadow-soft-2xl hover:scale-102">Active</a>
                              @endif
                          </td>
                      </tr>
                  @endforeach
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
@endsection
