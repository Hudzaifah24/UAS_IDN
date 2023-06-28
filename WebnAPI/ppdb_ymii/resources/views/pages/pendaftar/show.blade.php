<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="apple-touch-icon" sizes="76x76" href="{{ asset('assets/img/logo-ct.png') }}" />
    <link rel="icon" type="image/png" href="{{ asset('assets/img/logo-ct.png') }}" />
    <title>YMII | Profile</title>
    @include('scripts.styles')
    <!--     Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <!-- Nucleo Icons -->
    <link href="{{ asset('assets/css/nucleo-icons.css') }}" rel="stylesheet" />
    <link href="{{ asset('assets/css/nucleo-svg.css') }}" rel="stylesheet" />
    <!-- Popper -->
    <script src="https://unpkg.com/@popperjs/core@2"></script>
    <!-- Main Styling -->
    <link href="{{ asset('assets/css/soft-ui-dashboard-tailwind.css?v=1.0.5') }}" rel="stylesheet" />

    <!-- Nepcha Analytics (nepcha.com) -->
    <!-- Nepcha is a easy-to-use web analytics. No cookies and fully compliant with GDPR, CCPA and PECR. -->
    <script defer data-site="yayasanmutiaraihsanindonesia.my.id" src="https://api.nepcha.com/js/nepcha-analytics.js"></script>
  </head>
  <body class="m-0 font-sans antialiased font-normal text-base leading-default bg-gray-50 text-slate-500">
    {{-- Sidebar --}}
    @include('layouts.sidebar')

    <div class="ease-soft-in-out xl:ml-68.5 relative h-full max-h-screen bg-gray-50 transition-all duration-200">
      <nav class="absolute z-20 flex flex-wrap items-center justify-between w-full px-6 py-2 text-white transition-all shadow-none duration-250 ease-soft-in lg:flex-nowrap lg:justify-start" navbar-profile navbar-scroll="true">
        <div class="flex items-center justify-between w-full px-6 py-1 mx-auto flex-wrap-inherit">
          <nav>
            <!-- breadcrumb -->
            <ol class="flex flex-wrap pt-1 pl-2 pr-4 mr-12 bg-transparent rounded-lg sm:mr-16">
              <li class="leading-normal text-sm">
                <a class="opacity-50" href="{{ route('pendaftar.index') }}">Dashboard</a>
              </li>
              <li class="text-sm pl-2 capitalize leading-normal before:float-left before:pr-2 before:content-['/']" aria-current="page">Profile {{ $user->username }}</li>
            </ol>
            <h6 class="mb-2 ml-2 font-bold text-white capitalize">Profile {{ $user->username }}</h6>
          </nav>

          <div class="flex items-center mt-2 grow sm:mt-0 sm:mr-6 md:mr-0 lg:flex lg:basis-auto">
            <div class="flex items-center md:ml-auto md:pr-4">
              {{-- <div class="relative flex flex-wrap items-stretch w-full transition-all rounded-lg ease-soft">
                <span class="text-sm ease-soft leading-5.6 absolute z-50 -ml-px flex h-full items-center whitespace-nowrap rounded-lg rounded-tr-none rounded-br-none border border-r-0 border-transparent bg-transparent py-2 px-2.5 text-center font-normal text-slate-500 transition-all">
                  <i class="fas fa-search" aria-hidden="true"></i>
                </span>
                <input type="text" class="pl-8.75 text-sm focus:shadow-soft-primary-outline ease-soft w-1/100 leading-5.6 relative -ml-px block min-w-0 flex-auto rounded-lg border border-solid border-gray-300 bg-white bg-clip-padding py-2 pr-3 text-gray-700 transition-all placeholder:text-gray-500 focus:border-fuchsia-300 focus:outline-none focus:transition-shadow" placeholder="Type here..." />
              </div> --}}
            </div>
            <ul class="flex flex-row justify-end pl-0 mb-0 list-none md-max:w-full">
              <!-- online builder btn  -->
              <!-- <li class="flex items-center">
                <a class="inline-block px-8 py-2 mb-0 mr-4 font-bold text-center text-white uppercase align-middle transition-all border border-solid rounded-lg shadow-none cursor-pointer leading-pro border-white/75 bg-white/10 ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft hover:border-white hover:bg-transparent hover:text-white hover:opacity-75 hover:shadow-none active:bg-white active:text-black active:hover:bg-transparent active:hover:text-white" target="_blank" href="https://www.creative-tim.com/builder/soft-ui?ref=navbar-dashboard&amp;_ga=2.76518741.1192788655.1647724933-1242940210.1644448053">Online Builder</a>
              </li> -->
              <li class="flex items-center pl-4 xl:hidden">
                <a href="javascript:;" class="block p-0 text-white transition-all ease-soft-in-out text-sm" sidenav-trigger>
                  <div class="w-4.5 overflow-hidden">
                    <i class="ease-soft mb-0.75 relative block h-0.5 rounded-sm bg-white transition-all"></i>
                    <i class="ease-soft mb-0.75 relative block h-0.5 rounded-sm bg-white transition-all"></i>
                    <i class="ease-soft relative block h-0.5 rounded-sm bg-white transition-all"></i>
                  </div>
                </a>
              </li>
              <li class="flex items-center px-4">
                <a href="javascript:;" class="p-0 text-white transition-all text-sm ease-soft-in-out">
                  <!-- fixed-plugin-button-nav  -->
                </a>
              </li>
            </ul>
          </div>
        </div>
      </nav>

      <div class="w-full px-6 mx-auto">
        <div class="relative flex items-center p-0 mt-6 overflow-hidden bg-center bg-cover min-h-75 rounded-2xl" style="background-image: url('../assets/img/curved-images/curved0.jpg'); background-position-y: 50%">
          <span class="absolute inset-y-0 w-full h-full bg-center bg-cover bg-gradient-to-tl from-slate-700 to-blue-500 opacity-60"></span>
        </div>
        <div class="relative flex flex-col flex-auto min-w-0 p-4 mx-6 -mt-16 overflow-hidden break-words border-0 shadow-blur rounded-2xl bg-white/80 bg-clip-border backdrop-blur-2xl backdrop-saturate-200">
          <div class="flex flex-wrap -mx-3">
            <div class="flex-none w-auto max-w-full px-3">
              <div style='background-image: url("{{ $user->photo ? asset('assets/img/profile/'. $user->photo) : asset('assets/img/pp.jpg') }}")' class="bg-cover text-base ease-soft-in-out h-18.5 w-18.5 relative inline-flex items-center justify-center rounded-xl text-white transition-all duration-200">
              </div>
            </div>
            <div class="flex-none w-auto max-w-full px-3 my-auto">
              <div class="h-full">
                <h5 class="mb-1 capitalize">{{ $user->name }}</h5>
                <p class="mb-0 font-semibold leading-normal text-sm capitalize">{{ $user->role }}</p>
              </div>
            </div>
            <div class="px-5 mx-auto mt-4 sm:my-auto sm:mr-0">
                <div class="relative right-0">
                  <ul class="relative flex p-1 bg-transparent rounded-xl">
                    <li class="z-30 flex justify-end text-center">
                        <div class="w-full max-w-full px-3 text-right shrink-0 md:w-4/12 md:flex-none">
                            <a href="{{ route('profile.edit', $user->username) }}" data-target="tooltip_trigger" data-placement="top">
                                <i class="leading-normal fas fa-user-edit text-sm text-slate-400"></i>
                            </a>
                            <div data-target="tooltip" class="hidden px-2 py-1 text-center text-white bg-black rounded-lg text-sm" role="tooltip">
                                Edit Profile
                                <div class="invisible absolute h-2 w-2 bg-inherit before:visible before:absolute before:h-2 before:w-2 before:rotate-45 before:bg-inherit before:content-['']" data-popper-arrow></div>
                            </div>
                        </div>
                    </li>
                  </ul>
                </div>
              </div>
          </div>
        </div>
      </div>
      <div class="w-full p-6 mx-auto">
        <div class="flex flex-wrap -mx-3">
          @if($user->role == 'peserta')
            <div class="w-full max-w-full px-3 xl:w-4/12">
              <div class="relative flex flex-col h-full min-w-0 break-words bg-white border-0 shadow-soft-xl rounded-2xl bg-clip-border">
                <div class="p-4 pb-0 mb-0 bg-white border-b-0 rounded-t-2xl">
                  <h6 class="mb-0">Aplikasi</h6>
                </div>
                <div class="flex-auto p-4">
                  <h6 class="font-bold leading-tight uppercase text-xs text-slate-700">Jenis Aplikasi</h6>
                  <ul class="flex flex-col pl-0 mb-0 rounded-lg">
                    <li class="relative block px-0 py-2 bg-white border-0 rounded-t-lg text-inherit">
                      <div class="min-h-6 mb-0.5 block pl-0">
                          <p class="leading-normal text-sm capitalize">{{ $user->Application->status == 'pp' ? 'Pulang-Pergi' : 'Pondok' }}</p>
                      </div>
                    </li>
                  </ul>
                  <h6 class="font-bold leading-tight uppercase text-xs text-slate-700">Biaya yang harus dibayarkan</h6>
                  <ul class="flex flex-col pl-0 mb-0 rounded-lg">
                    <li class="relative block px-0 py-2 bg-white border-0 rounded-t-lg text-inherit">
                        <div class="min-h-6 mb-0.5 block pl-0">
                          <p class="leading-normal inline text-sm {{ $user->Application->bukti_pembayaran ? 'text-green-500' : '' }} capitalize"><b>Pendaftaran</b> : Rp {{ $user->Application->status == 'pp' ? '200.000' : '200.000' }}</p>@if($user->Application->bukti_pembayaran) <i class="fa fa-check inline text-sm text-green-500"></i> @endif
                        </div>
                        <div class="min-h-6 mb-0.5 block pl-0">
                            <p class="leading-normal inline text-sm"><b>Uang Pangkal</b> : Rp 6.000.000</p>
                        </div>
                        <div class="min-h-6 mb-0.5 block pl-0">
                            <p class="leading-normal text-sm capitalize"><b>SPP Bulanan</b> : Rp {{ $user->Application->status == 'pp' ? '300.000' : '800.000' }}</p>
                        </div>
                    </li>
                  </ul>
                  <a href="{{ route('pay', $user->username) }}" class="inline-block px-8 py-2 my-2 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-slate-700 to-blue-500 hover:shadow-soft-2xl hover:scale-102">Bayar</a>
                </div>
              </div>
            </div>
          @endif
          <div class="w-full max-w-full px-3 lg-max:mt-6 {{ $user->role == 'admin' ? 'xl:w-full' : 'xl:w-4/12' }}">
            <div class="relative flex flex-col h-full min-w-0 break-words bg-white border-0 shadow-soft-xl rounded-2xl bg-clip-border">
              <div class="p-4 pb-0 mb-0 bg-white border-b-0 rounded-t-2xl">
                <div class="flex flex-wrap -mx-3">
                  <div class="flex items-center w-full max-w-full px-3 shrink-0 md:w-8/12 md:flex-none">
                    <h6 class="mb-0">Informasi Profile</h6>
                  </div>
                </div>
              </div>
              <div class="flex-auto p-4">
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
          @if($user->role == 'peserta')
            <div class="w-full max-w-full px-3 lg-max:mt-6 xl:w-4/12">
              <div class="relative flex flex-col h-full min-w-0 break-words bg-white border-0 shadow-soft-xl rounded-2xl bg-clip-border">
                <div class="p-4 pb-0 mb-0 bg-white border-b-0 rounded-t-2xl">
                  <div class="flex flex-wrap -mx-3">
                    <div class="flex items-center w-full max-w-full px-3 shrink-0 md:w-8/12 md:flex-none">
                      <h6 class="mb-0">Informasi Orang Tua</h6>
                    </div>
                  </div>
                </div>
                <div class="flex-auto p-4">
                  <ul class="flex flex-col pl-0 mb-0 rounded-lg">
                    <li class="relative block px-4 py-2 pt-0 pl-0 leading-normal bg-white border-0 rounded-t-lg text-sm text-inherit"><strong class="text-slate-700">Nama Abi:</strong> &nbsp; {{ $user->nama_ayah }}</li>
                    <li class="relative block px-4 py-2 pl-0 leading-normal bg-white border-0 border-t-0 text-sm text-inherit"><strong class="text-slate-700">Nama Umi:</strong> &nbsp; {{ $user->nama_ibu }}</li>
                    <li class="relative block px-4 py-2 pl-0 leading-normal bg-white border-0 border-t-0 text-sm text-inherit"><strong class="text-slate-700">Nomor telpon Abi:</strong> &nbsp; <a class="text-blue-500 underline" target="__blank" href="{{ $user->no_tlp_ayah ? 'https://wa.me/+62'.$user->no_tlp_ayah : "#"}}">{{ $user->no_tlp_ayah ? '+62'.$user->no_tlp_ayah : ""}}</a></li>
                    <li class="relative block px-4 py-2 pl-0 leading-normal bg-white border-0 border-t-0 text-sm text-inherit"><strong class="text-slate-700">Nomor telpon Ummi:</strong> &nbsp; <a class="text-blue-500 underline" target="__blank" href="{{ $user->no_tlp_ibu ? 'https://wa.me/+62'.$user->no_tlp_ibu : "#"}}">{{ $user->no_tlp_ibu ? '+62'.$user->no_tlp_ibu : ""}}</a></li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="flex-none w-full max-w-full px-3 mt-6">
              <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 shadow-soft-xl rounded-2xl bg-clip-border">
                <div class="p-4 pb-0 mb-0 bg-white rounded-t-2xl">
                  <h6 class="mb-1">Progres</h6>
                  <p class="leading-normal text-sm">Aplikasi {{ $user->Application->status == 'pp' ? 'Pulang-Pergi' : 'Pondok' }}</p>
                </div>
                <div class="flex-auto p-4">
                  <div class="flex flex-wrap -mx-3">
                    <div class="w-full max-w-full px-3 mb-6 md:w-6/12 md:flex-none xl:mb-6 xl:w-3/12">
                      <div class="relative flex flex-col min-w-0 break-words bg-transparent border-0 shadow-none rounded-2xl bg-clip-border">
                        <div class="relative">
                          <a class="block shadow-soft-2xl rounded-2xl bg-center bg-cover lg:h-40 h-52 " style="background-image: url('{{ $user->Application->akte_kelahiran ? asset('assets/img/documents/'.$user->Application->akte_kelahiran) : asset('assets/img/home-decor-1.jpg') }}')">
                          </a>
                        </div>
                        <div class="flex-auto px-1 pt-6">
                          <p class="relative z-10 mb-2 leading-normal text-transparent bg-gradient-to-tl from-gray-900 to-slate-800 text-sm bg-clip-text">Langkah #1</p>
                          <a href="javascript:;">
                            <h5 class="mb-4 {{ $user->Application->akte_kelahiran != NULL ? 'text-green-500' : '' }}">Upload Akte Kelahiran</h5>
                          </a>
                          <div class="flex items-center justify-between">
                            @if($user->Application->budget)
                              @if($user->Application->akte_kelahiran == NULL)
                                  <a href="{{ route('ak', $user->username) }}" class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-slate-700 to-blue-500 hover:shadow-soft-2xl hover:scale-102">Upload</a>
                                  <button type="button" disabled class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-gray-500 text-gray-500 hover:border-gray-500 hover:bg-transparent hover:text-gray-500 hover:opacity-75 hover:shadow-none active:bg-gray-500 active:text-white active:hover:bg-transparent active:hover:text-gray-500">
                                      <i class="fa fa-eye"></i>
                                  </button>
                              @else
                                  <button type="button" disabled class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-gray-700 to-white hover:shadow-soft-2xl hover:scale-102">Upload</button>
                                  <a href="{{ route('ak', $user->username) }}" type="button" class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-fuchsia-500 text-fuchsia-500 hover:border-fuchsia-500 hover:bg-transparent hover:text-fuchsia-500 hover:opacity-75 hover:shadow-none active:bg-fuchsia-500 active:text-white active:hover:bg-transparent active:hover:text-fuchsia-500">
                                      <i class="fa fa-eye"></i>
                                  </a>
                              @endif
                            @else
                                <button type="button" disabled class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-gray-700 to-white hover:shadow-soft-2xl hover:scale-102">Upload</button>
                                <button type="button" disabled class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-gray-500 text-gray-500 hover:border-gray-500 hover:bg-transparent hover:text-gray-500 hover:opacity-75 hover:shadow-none active:bg-gray-500 active:text-white active:hover:bg-transparent active:hover:text-gray-500">
                                    <i class="fa fa-eye"></i>
                                </button>
                            @endif
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="w-full max-w-full px-3 mb-6 md:w-6/12 md:flex-none xl:mb-6 xl:w-3/12">
                      <div class="relative flex flex-col min-w-0 break-words bg-transparent border-0 shadow-none rounded-2xl bg-clip-border">
                        <div class="relative">
                          <a class="block shadow-soft-xl rounded-2xl bg-center bg-cover lg:h-40 h-52 " style="background-image: url('{{ $user->Application->kartu_keluarga ? asset('assets/img/documents/'.$user->Application->kartu_keluarga) : asset('assets/img/home-decor-2.jpg') }}')">
                          </a>
                        </div>
                        <div class="flex-auto px-1 pt-6">
                          <p class="relative z-10 mb-2 leading-normal text-transparent bg-gradient-to-tl from-gray-900 to-slate-800 text-sm bg-clip-text">Langkah #2</p>
                          <a href="javascript:;">
                            <h5 class="mb-4 {{ $user->Application->kartu_keluarga != NULL ? 'text-green-500' : '' }}">Upload Kartu Keluarga</h5>
                          </a>
                          <div class="flex items-center justify-between">
                            @if($user->Application->akte_kelahiran)
                                @if($user->Application->kartu_keluarga == NULL)
                                    <a href="{{ route('kk', $user->username) }}" class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-slate-700 to-blue-500 hover:shadow-soft-2xl hover:scale-102">Upload</a>
                                    <button type="button" disabled class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-gray-500 text-gray-500 hover:border-gray-500 hover:bg-transparent hover:text-gray-500 hover:opacity-75 hover:shadow-none active:bg-gray-500 active:text-white active:hover:bg-transparent active:hover:text-gray-500">
                                        <i class="fa fa-eye"></i>
                                    </button>
                                @else
                                    <button type="button" disabled class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-gray-700 to-white hover:shadow-soft-2xl hover:scale-102">Upload</button>
                                    <a href="{{ route('kk', $user->username) }}" type="button" class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-fuchsia-500 text-fuchsia-500 hover:border-fuchsia-500 hover:bg-transparent hover:text-fuchsia-500 hover:opacity-75 hover:shadow-none active:bg-fuchsia-500 active:text-white active:hover:bg-transparent active:hover:text-fuchsia-500">
                                        <i class="fa fa-eye"></i>
                                    </a>
                                @endif
                            @else
                                <button type="button" disabled class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-gray-700 to-white hover:shadow-soft-2xl hover:scale-102">Upload</button>
                                <button type="button" disabled class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-gray-500 text-gray-500 hover:border-gray-500 hover:bg-transparent hover:text-gray-500 hover:opacity-75 hover:shadow-none active:bg-gray-500 active:text-white active:hover:bg-transparent active:hover:text-gray-500">
                                    <i class="fa fa-eye"></i>
                                </button>
                            @endif
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="w-full max-w-full px-3 mb-6 md:w-6/12 md:flex-none xl:mb-6 xl:w-3/12">
                      <div class="relative flex flex-col min-w-0 break-words bg-transparent border-0 shadow-none rounded-2xl bg-clip-border">
                        <div class="relative">
                          <a class="block shadow-soft-2xl rounded-2xl bg-center bg-cover lg:h-40 h-52 " style="background-image: url('{{ $user->Application->ktp_ayah ? asset('assets/img/documents/'.$user->Application->ktp_ayah) : asset('assets/img/illustrations/kartu-tanda-pengenal2.jpg') }}')"></a>
                        </div>
                        <div class="flex-auto px-1 pt-6">
                          <p class="relative z-10 mb-2 leading-normal text-transparent bg-gradient-to-tl from-gray-900 to-slate-800 text-sm bg-clip-text">Langkah #3</p>
                          <a href="javascript:;">
                            <h5 class="mb-4 {{ $user->Application->ktp_ayah != NULL ? 'text-green-500' : '' }}">Upload KTP Abi</h5>
                          </a>
                          <div class="flex items-center justify-between">
                            @if($user->Application->kartu_keluarga)
                                @if($user->Application->ktp_ayah == NULL)
                                    <a href="{{ route('ka', $user->username) }}" class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-slate-700 to-blue-500 hover:shadow-soft-2xl hover:scale-102">Upload</a>
                                    <button type="button" disabled class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-gray-500 text-gray-500 hover:border-gray-500 hover:bg-transparent hover:text-gray-500 hover:opacity-75 hover:shadow-none active:bg-gray-500 active:text-white active:hover:bg-transparent active:hover:text-gray-500">
                                        <i class="fa fa-eye"></i>
                                    </button>
                                @else
                                    <button type="button" disabled class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-gray-700 to-white hover:shadow-soft-2xl hover:scale-102">Upload</button>
                                    <a href="{{ route('ka', $user->username) }}" type="button" class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-fuchsia-500 text-fuchsia-500 hover:border-fuchsia-500 hover:bg-transparent hover:text-fuchsia-500 hover:opacity-75 hover:shadow-none active:bg-fuchsia-500 active:text-white active:hover:bg-transparent active:hover:text-fuchsia-500">
                                        <i class="fa fa-eye"></i>
                                    </a>
                                @endif
                            @else
                                <button type="button" disabled class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-gray-700 to-white hover:shadow-soft-2xl hover:scale-102">Upload</button>
                                <button type="button" disabled class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-gray-500 text-gray-500 hover:border-gray-500 hover:bg-transparent hover:text-gray-500 hover:opacity-75 hover:shadow-none active:bg-gray-500 active:text-white active:hover:bg-transparent active:hover:text-gray-500">
                                    <i class="fa fa-eye"></i>
                                </button>
                            @endif
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="w-full max-w-full px-3 mb-6 md:w-6/12 md:flex-none xl:mb-6 xl:w-3/12">
                      <div class="relative flex flex-col min-w-0 break-words bg-transparent border-0 shadow-none rounded-2xl bg-clip-border">
                        <div class="relative">
                          <a class="block shadow-soft-2xl rounded-2xl bg-center bg-cover lg:h-40 h-52 " style="background-image: url('{{ $user->Application->ktp_ibu ? asset('assets/img/documents/'.$user->Application->ktp_ibu) : asset('assets/img/illustrations/kartu-tanda-pengenal.png') }}')"></a>
                        </div>
                        <div class="flex-auto px-1 pt-6">
                          <p class="relative z-10 mb-2 leading-normal text-transparent bg-gradient-to-tl from-gray-900 to-slate-800 text-sm bg-clip-text">Langkah #3</p>
                          <a href="javascript:;">
                            <h5 class="mb-4 {{ $user->Application->ktp_ibu != NULL ? 'text-green-500' : '' }}">Upload KTP Ummi</h5>
                          </a>
                          <div class="flex items-center justify-between">
                            @if($user->Application->ktp_ayah)
                                @if($user->Application->ktp_ibu == NULL)
                                    <a href="{{ route('ki', $user->username) }}" class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-slate-700 to-blue-500 hover:shadow-soft-2xl hover:scale-102">Upload</a>
                                    <button type="button" disabled class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-gray-500 text-gray-500 hover:border-gray-500 hover:bg-transparent hover:text-gray-500 hover:opacity-75 hover:shadow-none active:bg-gray-500 active:text-white active:hover:bg-transparent active:hover:text-gray-500">
                                        <i class="fa fa-eye"></i>
                                    </button>
                                @else
                                    <button type="button" disabled class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-gray-700 to-white hover:shadow-soft-2xl hover:scale-102">Upload</button>
                                    <a href="{{ route('ki', $user->username) }}" type="button" class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-fuchsia-500 text-fuchsia-500 hover:border-fuchsia-500 hover:bg-transparent hover:text-fuchsia-500 hover:opacity-75 hover:shadow-none active:bg-fuchsia-500 active:text-white active:hover:bg-transparent active:hover:text-fuchsia-500">
                                        <i class="fa fa-eye"></i>
                                    </a>
                                @endif
                            @else
                                <button type="button" disabled class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-gray-700 to-white hover:shadow-soft-2xl hover:scale-102">Upload</button>
                                <button type="button" disabled class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-gray-500 text-gray-500 hover:border-gray-500 hover:bg-transparent hover:text-gray-500 hover:opacity-75 hover:shadow-none active:bg-gray-500 active:text-white active:hover:bg-transparent active:hover:text-gray-500">
                                    <i class="fa fa-eye"></i>
                                </button>
                            @endif
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="w-full max-w-full px-3 mb-6 md:w-6/12 md:flex-none xl:mb-6 xl:w-3/12">
                      <div class="relative flex flex-col min-w-0 break-words bg-transparent border-0 shadow-none rounded-2xl bg-clip-border">
                        <div class="relative">
                          <a class="block shadow-soft-2xl rounded-2xl bg-center bg-cover lg:h-40 h-52 " style="background-image: url('{{ $user->Application->ijazah_terakhir ? asset('assets/img/documents/'.$user->Application->ijazah_terakhir) : asset('assets/img/home-decor-3.jpg') }}')">
                          </a>
                        </div>
                        <div class="flex-auto px-1 pt-6">
                          <p class="relative z-10 mb-2 leading-normal text-transparent bg-gradient-to-tl from-gray-900 to-slate-800 text-sm bg-clip-text">Langkah #4</p>
                          <a href="javascript:;">
                            <h5 class="mb-4 {{ $user->Application->ijazah_terakhir != NULL ? 'text-green-500' : '' }}">Upload Ijazah Terakhir</h5>
                          </a>
                          <div class="flex items-center justify-between">
                            @if($user->Application->ktp_ibu)
                                @if($user->Application->ijazah_terakhir == NULL)
                                    <a href="{{ route('it', $user->username) }}" class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-slate-700 to-blue-500 hover:shadow-soft-2xl hover:scale-102">Upload</a>
                                    <button type="button" disabled class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-gray-500 text-gray-500 hover:border-gray-500 hover:bg-transparent hover:text-gray-500 hover:opacity-75 hover:shadow-none active:bg-gray-500 active:text-white active:hover:bg-transparent active:hover:text-gray-500">
                                        <i class="fa fa-eye"></i>
                                    </button>
                                @else
                                    <button type="button" disabled class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-gray-700 to-white hover:shadow-soft-2xl hover:scale-102">Upload</button>
                                    <a href="{{ route('it', $user->username) }}" type="button" class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-fuchsia-500 text-fuchsia-500 hover:border-fuchsia-500 hover:bg-transparent hover:text-fuchsia-500 hover:opacity-75 hover:shadow-none active:bg-fuchsia-500 active:text-white active:hover:bg-transparent active:hover:text-fuchsia-500">
                                        <i class="fa fa-eye"></i>
                                    </a>
                                @endif
                            @else
                                <button type="button" disabled class="inline-block px-8 py-2 my-4 text-xs font-bold text-center text-white uppercase align-middle transition-all ease-in border-0 rounded-lg select-none shadow-soft-md bg-150 bg-x-25 leading-pro bg-gradient-to-tl from-gray-700 to-white hover:shadow-soft-2xl hover:scale-102">Upload</button>
                                <button type="button" disabled class="inline-block px-8 py-2 mb-0 font-bold text-center uppercase align-middle transition-all bg-transparent border border-solid rounded-lg shadow-none cursor-pointer leading-pro ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft border-gray-500 text-gray-500 hover:border-gray-500 hover:bg-transparent hover:text-gray-500 hover:opacity-75 hover:shadow-none active:bg-gray-500 active:text-white active:hover:bg-transparent active:hover:text-gray-500">
                                    <i class="fa fa-eye"></i>
                                </button>
                            @endif
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          @endif
        </div>
        <footer class="pt-4">
          <div class="w-full px-6 mx-auto">
            <div class="flex flex-wrap items-center -mx-3 lg:justify-between">
              <div class="w-full max-w-full px-3 mt-0 mb-6 shrink-0 lg:mb-0 lg:w-1/2 lg:flex-none">
                <div class="leading-normal text-center text-sm text-slate-500 lg:text-left">
                  ©
                  <script>
                    document.write(new Date().getFullYear() + ",");
                  </script>
                  made with <i class="fa fa-heart"></i> by
                  <a href="https://portfolio.sixredstarstech.my.id" class="font-semibold text-slate-700" target="_blank">Six Red Stars Technology</a>
                </div>
              </div>
            </div>
          </div>
        </footer>
      </div>
    </div>
  </body>
  <script src="{{ asset('assets/js/sidenav-burger.js') }}"></script>
  @include('scripts.scripts')
</html>
