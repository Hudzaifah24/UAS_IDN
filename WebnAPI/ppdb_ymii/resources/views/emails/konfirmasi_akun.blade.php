<x-mail::message>
# Kode Konfirmasi & Aktifasi Akun PPDB Pondok Belajar Mutiara Ihsan Atas Nama : {{ $user->name }}

<p>Kepada an/i {{ $user->name }} untuk segera mengaktifasi akun dengan kode :</p>
<br><br>
<p style="color: black; font-weight: 700">{{ $user->token }}</p>
<br><br>
<p>Masukkan kode kedalam inputan yang sudah disediakan pada halaman pendaftar.</p>
<br>
<br>

<p>Nama : {{ $user->name }}</p>
<p>email : {{ $user->email }}</p>
<p>username : {{ $user->username }}</p>
<br>
<br>

<x-mail::button url="{{ route('konfirmasi') }}">
Konfirmasi Akun
</x-mail::button>

Jazakumullahukhiron,<br>
{{ config('app.name') }}
</x-mail::message>
