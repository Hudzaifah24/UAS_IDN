<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Models\User;
use App\Models\Application;
use Illuminate\Support\Facades\Auth;

class DashboardController extends Controller
{
    public function index()
    {
        $user = User::findOrFail(Auth::user()->id);
        $usersCount = User::count();
        $newUsersCount = User::whereDay('created_at', Carbon::now())->where('role', 'peserta')->count();
        $newUsersMonth = User::whereMonth('created_at', Carbon::now())->where('role', 'peserta')->get();
        $aplikasiMampuCount = Application::where('status', 'mampu')->count();
        $aplikasiTidakMampuCount = Application::where('status', 'tidak_mampu')->count();
        $pemasukan = Application::sum('budget');
        $newPemasukan = Application::whereDay('created_at', Carbon::now())->sum('budget');

        $aplikasi = Application::where('user_id', Auth::user()->id)->first();
        if ($aplikasi) {
            $al = $aplikasi->akte_kelahiran == NULL ? 0 : 1;
            $kk = $aplikasi->kartu_keluarga == NULL ? 0 : 1;
            $ka = $aplikasi->ktp_ayah == NULL ? 0 : 1;
            $ki = $aplikasi->ktp_ibu == NULL ? 0 : 1;
            $it = $aplikasi->ijazah_terakhir == NULL ? 0 : 1;
            $pb = $aplikasi->budget == NULL ? 0 : 1;

            $total = $al + $kk + $ka + $ki + $it + $pb;
            $progres = number_format($total / 6 * 100);
        } else {
            $progres = 0;
        }

        return view('dashboard', [
            'usersCount' => $usersCount,
            'newUsersCount' => $newUsersCount,
            'newUsersMonth' => $newUsersMonth,
            'aplikasiMampuCount' => $aplikasiMampuCount,
            'aplikasiTidakMampuCount' => $aplikasiTidakMampuCount,
            'pemasukan' => $pemasukan,
            'newPemasukan' => $newPemasukan,
            'progres' => $progres,
            'user' => $user,
        ]);
    }
}
