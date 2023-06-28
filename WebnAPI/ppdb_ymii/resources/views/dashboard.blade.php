@extends('layouts.parent')

@section('title', 'Dashboard')

@section('content')

    <!-- row 1 -->
    <div class="flex flex-wrap -mx-3">
        @if ($user->role != 'peserta')
            <!-- card1 -->
            <div class="w-full max-w-full px-3 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/4">
                <div class="relative flex flex-col min-w-0 break-words bg-white shadow-soft-xl rounded-2xl bg-clip-border">
                <div class="flex-auto p-4">
                    <div class="flex flex-row -mx-3">
                    <div class="flex-none w-2/3 max-w-full px-3">
                        <div>
                        <p class="mb-0 font-sans text-sm font-semibold leading-normal">Pemasukan</p>
                        <h5 class="mb-0 font-bold">
                            Rp {{ number_format($pemasukan) }}
                            @if ($newPemasukan != 0)
                                <span class="text-sm leading-normal font-weight-bolder text-lime-500">+Rp{{ $newPemasukan }}</span>
                            @endif
                        </h5>
                        </div>
                    </div>
                    <div class="px-3 text-right basis-1/3">
                        <div class="inline-block w-12 h-12 text-center rounded-lg bg-gradient-to-tl from-slate-700 to-blue-500">
                        <i class="ni leading-none ni-money-coins text-lg relative top-3.5 text-white"></i>
                        </div>
                    </div>
                    </div>
                </div>
                </div>
            </div>

            <!-- card2 -->
            <div class="w-full max-w-full px-3 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/4">
                <div class="relative flex flex-col min-w-0 break-words bg-white shadow-soft-xl rounded-2xl bg-clip-border">
                <div class="flex-auto p-4">
                    <div class="flex flex-row -mx-3">
                    <div class="flex-none w-2/3 max-w-full px-3">
                        <div>
                        <p class="mb-0 font-sans text-sm font-semibold leading-normal">Pengguna</p>
                        <h5 class="mb-0 font-bold">
                            {{ $usersCount }}
                            @if ($newUsersCount != 0)
                            <span class="text-sm leading-normal font-weight-bolder text-lime-500">+{{ $newUsersCount }}</span>
                            @endif
                        </h5>
                        </div>
                    </div>
                    <div class="px-3 text-right basis-1/3">
                        <div class="inline-block w-12 h-12 text-center rounded-lg bg-gradient-to-tl from-slate-700 to-blue-500">
                        <i class="leading-none fa fa-users text-lg relative top-3.5 text-white"></i>
                        </div>
                    </div>
                    </div>
                </div>
                </div>
            </div>

            <!-- card3 -->
            <div class="w-full max-w-full px-3 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/4">
                <div class="relative flex flex-col min-w-0 break-words bg-white shadow-soft-xl rounded-2xl bg-clip-border">
                <div class="flex-auto p-4">
                    <div class="flex flex-row -mx-3">
                    <div class="flex-none w-2/3 max-w-full px-3">
                        <div>
                        <p class="mb-0 font-sans text-sm font-semibold leading-normal">Aplikasi Mampu</p>
                        <h5 class="mb-0 font-bold">
                            {{ $aplikasiMampuCount }}
                        </h5>
                        </div>
                    </div>
                    <div class="px-3 text-right basis-1/3">
                        <div class="inline-block w-12 h-12 text-center rounded-lg bg-gradient-to-tl from-slate-700 to-blue-500">
                        <i class="ni leading-none ni-paper-diploma text-lg relative top-3.5 text-white"></i>
                        </div>
                    </div>
                    </div>
                </div>
                </div>
            </div>

            <!-- card4 -->
            <div class="w-full max-w-full px-3 sm:w-1/2 sm:flex-none xl:w-1/4">
                <div class="relative flex flex-col min-w-0 break-words bg-white shadow-soft-xl rounded-2xl bg-clip-border">
                <div class="flex-auto p-4">
                    <div class="flex flex-row -mx-3">
                    <div class="flex-none w-2/3 max-w-full px-3">
                        <div>
                        <p class="mb-0 font-sans text-sm font-semibold leading-normal">Aplikasi Tak Mampu</p>
                        <h5 class="mb-0 font-bold">
                            {{ $aplikasiTidakMampuCount }}
                        </h5>
                        </div>
                    </div>
                    <div class="px-3 text-right basis-1/3">
                        <div class="inline-block w-12 h-12 text-center rounded-lg bg-gradient-to-tl from-slate-700 to-blue-500">
                        <i class="leading-none fa fa-book text-lg relative top-3.5 text-white"></i>
                        </div>
                    </div>
                    </div>
                </div>
                </div>
            </div>
        @endif
      </div>

      <!-- cards row 4 -->

      <div class="flex flex-wrap my-6 -mx-3">
        <!-- card 1 -->

        <div class="w-full max-w-full px-3 mb-3 lg-max:mt-6 {{ $user->role == 'admin' ? 'xl:w-full' : 'xl:w-4/12' }}">
            <div class="relative flex flex-col h-full min-w-0 break-words bg-white border-0 shadow-soft-xl rounded-2xl bg-clip-border">
              <div class="p-4 pb-0 mb-0 bg-white border-b-0 rounded-t-2xl">
                <div class="flex flex-wrap -mx-3">
                  <div class="flex items-center w-full max-w-full px-3 shrink-0 md:w-8/12 md:flex-none">
                    <h6 class="mb-0">Informasi Profile</h6>
                  </div>
                  <div class="w-full max-w-full px-3 text-right shrink-0 md:w-4/12 md:flex-none">
                    <a href="{{ route('profile.edit', $user->username) }}" data-target="tooltip_trigger" data-placement="top">
                      <i class="leading-normal fas fa-user-edit text-sm text-slate-400"></i>
                    </a>
                    <div data-target="tooltip" class="hidden px-2 py-1 text-center text-white bg-black rounded-lg text-sm" role="tooltip">
                      Edit Profile
                      <div class="invisible absolute h-2 w-2 bg-inherit before:visible before:absolute before:h-2 before:w-2 before:rotate-45 before:bg-inherit before:content-['']" data-popper-arrow></div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="flex-auto p-4">
                <div class="w-auto max-w-full mx-auto mb-3">
                    <div style='background-image: url("{{ $user->photo ? asset('assets/img/profile/'. $user->photo) : asset('assets/img/pp.jpg') }}")' class="text-base ease-soft-in-out h-18.5 w-18.5 relative items-center justify-center rounded-xl text-white transition-all duration-200 bg-cover">
                    </div>
                </div>
                <ul class="flex flex-col pl-0 mb-0 rounded-lg">
                  <li class="relative block px-4 py-2 pt-0 pl-0 leading-normal bg-white border-0 rounded-t-lg text-sm text-inherit capitalize"><strong class="text-slate-700">Nama Lengkap:</strong> &nbsp; {{ $user->name }}</li>
                  <li class="relative block px-4 py-2 pl-0 leading-normal bg-white border-0 border-t-0 text-sm text-inherit"><strong class="text-slate-700">Username:</strong> &nbsp; {{ $user->username }}</li>
                  <li class="relative block px-4 py-2 pl-0 leading-normal bg-white border-0 border-t-0 text-sm text-inherit"><strong class="text-slate-700">Email:</strong> &nbsp; {{ $user->email }}</li>
                  <li class="relative block px-4 py-2 pl-0 leading-normal bg-white border-0 border-t-0 text-sm text-inherit"><strong class="text-slate-700">Alamat:</strong> &nbsp; {{ $user->alamat ? $user->alamat : "-" }}</li>
                  <li class="relative block px-4 py-2 pb-0 pl-0 bg-white border-0 border-t-0 rounded-b-lg text-inherit capitalize">
                    <strong class="leading-normal text-sm text-slate-700">Social:</strong> &nbsp;
                    @if ($user->Social)
                        @if ($user->Social->tiktok)
                            <a class="inline-block py-0 pl-1 pr-2 mb-0 font-bold text-center text-blue-800 align-middle transition-all bg-transparent border-0 rounded-lg shadow-none cursor-pointer leading-pro text-xs ease-soft-in bg-none" target="__blank" href="{{ $user->Social->tiktok }}">
                                <i class="fab fa-tiktok fa-lg"></i>
                            </a>
                        @endif
                        @if ($user->Social->twitter)
                            <a class="inline-block py-0 pl-1 pr-2 mb-0 font-bold text-center align-middle transition-all bg-transparent border-0 rounded-lg shadow-none cursor-pointer leading-pro text-xs ease-soft-in bg-none text-sky-600" target="__blank" href="{{ $user->Social->twitter }}">
                                <i class="fab fa-twitter fa-lg"></i>
                            </a>
                        @endif
                        @if ($user->Social->instagram)
                            <a class="inline-block py-0 pl-1 pr-2 mb-0 font-bold text-center align-middle transition-all bg-transparent border-0 rounded-lg shadow-none cursor-pointer leading-pro text-xs ease-soft-in bg-none text-sky-900" target="__blank" href="{{ $user->Social->instagram }}">
                                <i class="fab fa-instagram fa-lg"></i>
                            </a>
                        @endif
                    @else
                        -
                    @endif
                  </li>
                </ul>
              </div>
            </div>
        </div>

        @if($user->role == 'admin')
        <div class="w-full max-w-full px-3 mt-0 mb-6 md:mb-0 overflow-hidden {{ $user->role == 'admin' ? 'w-full' : 'md:w-1/2 lg:w-2/3' }} md:flex-none lg:flex-none">
            <div class="border-black/12.5 shadow-soft-xl relative flex min-w-0 flex-col break-words rounded-2xl border-0 border-solid bg-white bg-clip-border">
              <div class="border-black/12.5 mb-0 rounded-t-2xl border-b-0 border-solid bg-white p-6 pb-0">
                <div class="flex flex-wrap mt-0 -mx-3">
                  <div class="flex-none w-7/12 max-w-full px-3 mt-0 lg:w-1/2 lg:flex-none">
                    <h6>Kandidat</h6>
                    <p class="mb-0 text-sm leading-normal">
                      <i class="fa fa-check text-cyan-500"></i>
                      <span class="ml-1 font-semibold">{{ $newUsersMonth->count() }} orang</span>
                      Bulan ini
                    </p>
                  </div>
                  <div class="flex-none w-5/12 max-w-full px-3 my-auto text-right lg:w-1/2 lg:flex-none">
                  </div>
                </div>
              </div>
              <div class="flex-auto p-6 px-0 pb-2">
                <div class="overflow-x-auto">
                  <table class="items-center w-full mb-0 align-top border-gray-200 text-slate-500">
                    <thead class="align-bottom">
                      <tr>
                        <th class="px-6 py-3 font-bold tracking-normal text-left uppercase align-middle bg-transparent border-b letter border-b-solid text-xxs whitespace-nowrap border-b-gray-200 text-slate-400 opacity-70">Nama</th>
                        <th class="px-6 py-3 font-bold tracking-normal text-center uppercase align-middle bg-transparent border-b letter border-b-solid text-xxs whitespace-nowrap border-b-gray-200 text-slate-400 opacity-70">Budget</th>
                        <th class="px-6 py-3 font-bold tracking-normal text-center uppercase align-middle bg-transparent border-b letter border-b-solid text-xxs whitespace-nowrap border-b-gray-200 text-slate-400 opacity-70">Progres</th>
                      </tr>
                    </thead>
                    <tbody>
                      @foreach($newUsersMonth as $data)
                          @php
                            if ($data->Application) {
                                $al = $data->Application->akte_kelahiran == NULL ? 0 : 1;
                                $kk = $data->Application->kartu_keluarga == NULL ? 0 : 1;
                                $ka = $data->Application->ktp_ayah == NULL ? 0 : 1;
                                $ki = $data->Application->ktp_ibu == NULL ? 0 : 1;
                                $it = $data->Application->ijazah_terakhir == NULL ? 0 : 1;
                                $pb = $data->Application->budget == NULL ? 0 : 1;

                                $total = $al + $kk + $ka + $ki + $it + $pb;
                                $progresUser = number_format($total / 6 * 100);
                            } else {
                                $progresUser = 0;
                            }
                          @endphp
                        <tr>
                          <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap">
                            <div class="flex px-2 py-1">
                              {{-- <div>
                                <img src="./assets/img/small-logos/logo-xd.svg" class="inline-flex items-center justify-center mr-4 text-sm text-white transition-all duration-200 ease-soft-in-out h-9 w-9 rounded-xl" alt="xd" />
                              </div> --}}
                              <div class="flex flex-col justify-center">
                                <h6 class="mb-0 text-sm leading-normal">{{ $data->name }}</h6>
                              </div>
                            </div>
                          </td>
                          <td class="p-2 text-sm leading-normal text-center align-middle bg-transparent border-b whitespace-nowrap">
                            <span class="text-xs font-semibold leading-tight">Rp {{ number_format($data->Application == NULL ? 0 : $data->Application->budget) }}</span>
                          </td>
                          <td class="p-2 align-middle bg-transparent border-b whitespace-nowrap">
                            <div class="w-3/4 mx-auto">
                              <div>
                                <div>
                                  <span class="text-xs font-semibold leading-tight">{{ $progresUser }}%</span>
                                </div>
                              </div>
                              <div class="text-xs h-0.75 w-30 m-0 flex overflow-visible rounded-lg bg-gray-200">
                                <div class="duration-600 ease-soft bg-gradient-to-tl from-blue-600 to-cyan-400 -mt-0.38 -ml-px flex h-1.5 {{ 'w-['.$progresUser.'%]' }} flex-col justify-center overflow-hidden whitespace-nowrap rounded bg-fuchsia-500 text-center text-white transition-all" role="progressbar" aria-valuenow="{{ $progresUser }}" aria-valuemin="0" aria-valuemax="100"></div>
                              </div>
                            </div>
                          </td>
                        </tr>
                      @endforeach
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        @endif

        <!-- card 2 -->
        @if ($user->role == 'peserta')
            <div class="w-full max-w-full px-3 md:w-1/2 md:flex-none lg:w-1/3 lg:flex-none">
                <div class="border-black/12.5 shadow-soft-xl relative flex h-full min-w-0 flex-col break-words rounded-2xl border-0 border-solid bg-white bg-clip-border">
                    <div class="border-black/12.5 mb-0 rounded-t-2xl border-b-0 border-solid bg-white p-6 pb-0">
                    <h6>Progres</h6>
                    <p class="text-sm leading-normal">
                        @if ($progres == 0)
                            <i class="text-red-500">-</i>
                            <span class="font-semibold text-red-500">{{ $progres }}</span>
                        @elseif ($progres == 100)
                            <i class="fa fa-circle-o text-lime-500"></i>
                            <span class="font-semibold text-lime-500">{{ $progres }}%</span>
                        @else
                            <i class="fa fa-arrow-up text-lime-500"></i>
                            <span class="font-semibold">{{ $progres }}%</span>
                        @endif
                    </p>
                    </div>
                    <div class="flex-auto p-4">
                        <div class="before:border-r-solid relative before:absolute before:top-0 before:left-4 before:h-full before:border-r-2 before:border-r-slate-100 before:content-[''] before:lg:-ml-px">
                            <div class="relative mb-4 after:clear-both after:table after:content-['']">
                                <span class="w-6.5 h-6.5 text-base absolute left-4 z-10 inline-flex -translate-x-1/2 items-center justify-center rounded-full bg-white text-center font-semibold">
                                    <i class="relative z-10 leading-none text-transparent fa fa-money leading-pro bg-gradient-to-tl from-green-700 to-lime-500 bg-clip-text fill-transparent"></i>
                                </span>
                                <div class="ml-11.252 pt-1.4 lg:max-w-120 relative -top-1.5 w-auto">
                                    <h6 class="mb-0 text-sm font-semibold leading-normal {{ $user->Application->bukti_pembayaran == NULL ? 'text-slate-700' : 'text-green-700' }}">Pembayaran</h6>
                                    <p class="mt-1 mb-0 text-xs font-semibold leading-tight text-slate-400">{{ $user->Application->badget_time == NULL ? '-' : $user->Application->badget_time }}</p>
                                </div>
                            </div>
                            <div class="relative mb-4 mt-0 after:clear-both after:table after:content-['']">
                                <span class="w-6.5 h-6.5 text-base absolute left-4 z-10 inline-flex -translate-x-1/2 items-center justify-center rounded-full bg-white text-center font-semibold">
                                <i class="relative z-10 leading-none text-transparent fa fa-file-photo-o leading-pro bg-gradient-to-tl from-red-600 to-rose-400 bg-clip-text fill-transparent"></i>
                                </span>
                                <div class="ml-11.252 pt-1.4 lg:max-w-120 relative -top-1.5 w-auto">
                                <h6 class="mb-0 text-sm font-semibold leading-normal {{ $user->Application->akte_kelahiran == NULL ? 'text-slate-700' : 'text-green-700' }}">Upload Akte Kelahiran</h6>
                                <p class="mt-1 mb-0 text-xs font-semibold leading-tight text-slate-400">{{ $user->Application->akte_kelahiran_time == NULL ? '-' : $user->Application->akte_kelahiran_time }}</p>
                                </div>
                            </div>
                            <div class="relative mb-4 after:clear-both after:table after:content-['']">
                                <span class="w-6.5 h-6.5 text-base absolute left-4 z-10 inline-flex -translate-x-1/2 items-center justify-center rounded-full bg-white text-center font-semibold">
                                <i class="relative z-10 leading-none text-transparent fa fa-file leading-pro bg-gradient-to-tl from-yellow-600 to-rose-400 bg-clip-text fill-transparent"></i>
                                </span>
                                <div class="ml-11.252 pt-1.4 lg:max-w-120 relative -top-1.5 w-auto">
                                <h6 class="mb-0 text-sm font-semibold leading-normal {{ $user->Application->kartu_keluarga == NULL ? 'text-slate-700' : 'text-green-700' }}">Upload Kartu Keluarga</h6>
                                <p class="mt-1 mb-0 text-xs font-semibold leading-tight text-slate-400">{{ $user->Application->kartu_keluarga_time == NULL ? '-' : $user->Application->kartu_keluarga_time }}</p>
                                </div>
                            </div>
                            <div class="relative mb-4 after:clear-both after:table after:content-['']">
                                <span class="w-6.5 h-6.5 text-base absolute left-4 z-10 inline-flex -translate-x-1/2 items-center justify-center rounded-full bg-white text-center font-semibold">
                                <i class="relative z-10 leading-none text-transparent ni ni-credit-card leading-pro bg-gradient-to-tl from-blue-500 to-slate-400 bg-clip-text fill-transparent"></i>
                                </span>
                                <div class="ml-11.252 pt-1.4 lg:max-w-120 relative -top-1.5 w-auto">
                                <h6 class="mb-0 text-sm font-semibold leading-normal {{ $user->Application->ktp_ayah == NULL ? 'text-slate-700' : 'text-green-700' }}">Upload KTP Abi</h6>
                                <p class="mt-1 mb-0 text-xs font-semibold leading-tight text-slate-400">{{ $user->Application->ktp_ayah_time == NULL ? '-' : $user->Application->ktp_ayah_time }}</p>
                                </div>
                            </div>
                            <div class="relative mb-4 after:clear-both after:table after:content-['']">
                                <span class="w-6.5 h-6.5 text-base absolute left-4 z-10 inline-flex -translate-x-1/2 items-center justify-center rounded-full bg-white text-center font-semibold">
                                <i class="relative z-10 leading-none text-transparent ni ni-credit-card leading-pro bg-gradient-to-tl from-blue-500 to-slate-400 bg-clip-text fill-transparent"></i>
                                </span>
                                <div class="ml-11.252 pt-1.4 lg:max-w-120 relative -top-1.5 w-auto">
                                <h6 class="mb-0 text-sm font-semibold leading-normal {{ $user->Application->ktp_ibu == NULL ? 'text-slate-700' : 'text-green-700' }}">Upload KTP Ummi</h6>
                                <p class="mt-1 mb-0 text-xs font-semibold leading-tight text-slate-400">{{ $user->Application->ktp_ibu_time == NULL ? '-' : $user->Application->ktp_ibu_time }}</p>
                                </div>
                            </div>
                            <div class="relative mb-4 after:clear-both after:table after:content-['']">
                                <span class="w-6.5 h-6.5 text-base absolute left-4 z-10 inline-flex -translate-x-1/2 items-center justify-center rounded-full bg-white text-center font-semibold">
                                <i class="relative z-10 leading-none text-transparent fa fa-file-text-o leading-pro bg-gradient-to-tl from-slate-700 to-blue-500 bg-clip-text fill-transparent"></i>
                                </span>
                                <div class="ml-11.252 pt-1.4 lg:max-w-120 relative -top-1.5 w-auto">
                                <h6 class="mb-0 text-sm font-semibold leading-normal {{ $user->Application->ijazah_terakhir == NULL ? 'text-slate-700' : 'text-green-700' }}">Upload Ijazah terakhir</h6>
                                <p class="mt-1 mb-0 text-xs font-semibold leading-tight text-slate-400">{{ $user->Application->ijazah_terakhir_time == NULL ? '-' : $user->Application->ijazah_terakhir_time }}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        @endif
      </div>

@endsection
