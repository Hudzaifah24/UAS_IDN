<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="apple-touch-icon" sizes="76x76" href="{{ asset('assets/img/logo-ct.png') }}" />
    <link rel="icon" type="image/png" href="{{ asset('assets/img/logo-ct.png') }}" />
    <title>YMII | Pembayaran</title>
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
    <script defer data-site="YOUR_DOMAIN_HERE" src="https://api.nepcha.com/js/nepcha-analytics.js"></script>
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
                <a class="opacity-50" href="{{ route('profile') }}">Profile</a>
              </li>
              <li class="text-sm pl-2 capitalize leading-normal before:float-left before:pr-2 before:content-['/']" aria-current="page">Upload Pembayaran</li>
            </ol>
            <h6 class="mb-2 ml-2 font-bold text-white capitalize">Upload Pembayaran</h6>
          </nav>

          <div class="flex items-center mt-2 grow sm:mt-0 sm:mr-6 md:mr-0 lg:flex lg:basis-auto">
            <div class="flex items-center md:ml-auto md:pr-4">
            </div>
            <ul class="flex flex-row justify-end pl-0 mb-0 list-none md-max:w-full">
              <!-- online builder btn  -->
              <li class="flex items-center">
                <a class="inline-block px-8 py-2 mb-0 mr-4 font-bold text-center text-white uppercase align-middle transition-all border border-solid rounded-lg shadow-none cursor-pointer leading-pro border-white/75 bg-white/10 ease-soft-in text-xs hover:scale-102 active:shadow-soft-xs tracking-tight-soft hover:border-white hover:bg-transparent hover:text-white hover:opacity-75 hover:shadow-none active:bg-white active:text-black active:hover:bg-transparent active:hover:text-white" href="{{ route('profile') }}">Kembali ke Profile</a>
              </li>
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
        <div class="relative flex items-center p-0 mt-6 overflow-hidden bg-center bg-cover min-h-75 rounded-2xl" style="background-image: url('{{ asset('assets/img/curved-images/curved0.jpg') }}'); background-position-y: 50%">
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
          </div>
        </div>
      </div>
      <div class="w-full p-6 mx-auto">
        <div class="flex flex-wrap -mx-3">
            <div class="w-full max-w-full px-3 lg-max:mt-6 xl:w-full">
                <div class="relative flex flex-col h-full min-w-0 break-words bg-white border-0 shadow-soft-xl rounded-2xl bg-clip-border">
                    @if ($user->Application->bukti_pembayaran)
                        <a href="{{ asset('assets/img/bukti-pembayaran/'.$user->Application->bukti_pembayaran) }}" target="__blank">
                            <img class="object-cover h-full w-full rounded-lg" src="{{ $user->Application->bukti_pembayaran ? asset('assets/img/bukti-pembayaran/'. $user->Application->bukti_pembayaran) : '' }}">
                        </a>
                    @endif
                  <div class="p-4 pb-0 mb-0 bg-white border-b-0 rounded-t-2xl">
                    @if ($user->Application->bukti_pembayaran == NULL)
                        <h6 class="font-bold leading-tight uppercase text-xs text-slate-700">Biaya yang harus dibayarkan</h6>
                        <ul class="flex flex-col pl-0 mb-0 rounded-lg">
                            <li class="relative block px-0 py-2 bg-white border-0 rounded-t-lg text-inherit">
                                <div class="min-h-6 mb-0.5 block pl-0">
                                    <p class="leading-normal text-sm capitalize"><b>Pendaftaran</b> : Rp {{ $user->Application->status == 'pp' ? '200.000' : '200.000' }}</p>
                                </div>
                                <div class="min-h-6 mb-0.5 block pl-0">
                                    <p class="leading-normal text-sm capitalize"><b>No. rek</b> : 7154343697</p>
                                </div>
                                <div class="min-h-6 mb-0.5 block pl-0">
                                    <p class="leading-normal text-sm capitalize"><b>Bank</b> : BSI</p>
                                </div>
                                <div class="min-h-6 mb-0.5 block pl-0">
                                    <p class="leading-normal text-sm capitalize"><b>Atas Nama</b> : Sari Romlah</p>
                                </div>
                                <div class="min-h-6 mb-0.5 block pl-0">
                                    <p class="leading-normal text-sm">Jika sudah transfer, mohon untuk mengkonfirmasi ke WA 081575319184, dengan mengetikkan : <br><strong>BAYAR\spasi\pendaftaran\spasi\biaya\spasi\200000\spasi\NAMA BANK\spasi\NAMA PENGIRIM</strong></p>
                                </div>
                            </li>
                        </ul>
                    @endif
                    <div class="flex flex-wrap -mx-3">
                      <div class="flex items-center w-full max-w-full px-3 shrink-0 md:w-8/12 md:flex-none">
                        <h6 class="mb-0">Bukti Pembayaran</h6>
                      </div>
                    </div>
                  </div>
                  <div class="flex-auto p-4">
                    <ul class="flex flex-col pl-0 mb-0 rounded-lg">
                        <form role="form text-left" action="{{ route('pay.proses', $user->username) }}" method="POST" enctype="multipart/form-data">
                            @csrf
                            @method('POST')

                            <input name="photo" class="block w-full mb-5 p-3 text-xs text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="small_size" type="file">

                            <div class="text-center">
                              <button type="submit" class="inline-block w-full px-6 py-3 mt-6 mb-2 font-bold text-center text-white uppercase align-middle transition-all bg-transparent border-0 rounded-lg cursor-pointer active:opacity-85 hover:scale-102 hover:shadow-soft-xs leading-pro text-xs ease-soft-in tracking-tight-soft shadow-soft-md bg-150 bg-x-25 bg-gradient-to-tl from-slate-900 to-blue-800 hover:border-slate-700 hover:bg-slate-700 hover:text-white">{{ $user->Application->budget == NULL ? 'Tambah' : 'Ubah' }}</button>
                            </div>
                        </form>
                    </ul>
                  </div>
                </div>
            </div>
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
                  <a href="https://www.creative-tim.com" class="font-semibold text-slate-700" target="_blank">Six Red Stars Technology</a>
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
