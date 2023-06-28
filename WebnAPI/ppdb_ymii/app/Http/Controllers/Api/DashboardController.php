<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Application;
use App\Traits\ApiResponser;
use Illuminate\Support\Facades\Auth;

class DashboardController extends Controller
{
    use ApiResponser;

    public function countProgress()
    {
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

        $data = [
            'progress' => $progres,
            'application' => $aplikasi,
        ];

        return $this->success($data, 'Berhasil Menggugah Data', 200);
    }
}
