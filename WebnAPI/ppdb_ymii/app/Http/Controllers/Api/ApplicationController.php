<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Application;
use App\Traits\ApiResponser;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;

class ApplicationController extends Controller
{
    use ApiResponser;

    public function pilih_aplikasi(Request $request)
    {
        $data = $request->all();

        $data['user_id'] = Auth::user()->id;
        $data['status'] = $request->status;

        $application = Application::create($data);

        return $this->success($application, 'Applikasi anda ditentukan : '.$application->status, 200);
    }

    public function pembayaran(Request $request) {
        $request->validate([
            'bukti_pembayaran' => 'required|image|mimes:png,jpg,jpeg,pdf',
        ]);

        $file = $request->file('bukti_pembayaran');

        $application = Application::where('user_id', Auth::user()->id)->first();

        if (File::exists(public_path('assets/img/bukti-pembayaran/'. $application->bukti_pembayaran))) {
            File::delete(public_path(). '/assets/img/bukti-pembayaran/'.$application->bukti_pembayaran);
        }

        // hosting
        // if (File::exists(public_path('/../../assets/img/bukti-pembayaran/'. $application->bukti_pembayaran))) {
        //     File::delete(public_path('/../../assets/img/bukti-pembayaran/'. $application->bukti_pembayaran));
        // }

        $name_file = time().'.'.$file->getClientOriginalExtension();

        $file->move(public_path('assets/img/bukti-pembayaran'), $name_file);

        // hosting
        // $file->move(public_path('/../../public_html/assets/img/bukti-pembayaran'), $name_file);

        $application->update([
            'bukti_pembayaran' => $name_file,
            'budget' => 200000,
            'budget_time' => Carbon::now(),
        ]);

        return $this->success($application, 'Berhasil Mengirim Bukti', 200);
    }

    public function getDocuments() {
        $user = Auth::user();

        $application = Application::where('user_id', $user->id)->first();

        if (!$application) {
            return $this->error("Gagal Mengambil Data Aplikasi");
        }

        return $this->success($application, "Berhasil Mengambil Data Aplikasi", 200);
    }

    public function documents(Request $request)
    {
        $user = Auth::user();

        $request->validate([
            'document' => 'required|image|mimes:png,jpg,jpeg,pdf',
        ]);

        $file = $request->file('document');

        $application = Application::where('user_id', $user->id)->first();

        if (!$application) {
            return $this->error('Aplikasi pendaftaran belum ditentukan');
        }

        $name_file = time().'.'.$file->getClientOriginalExtension();

        switch ($request->jenis) {
            case 'akte_kelahiran':
                // if (File::exists(public_path('assets/img/documents/'. $application->akte_kelahiran))) {
                //     File::delete(public_path(). '/assets/img/documents/'.$application->akte_kelahiran);
                // }

                // hosting
                if (File::exists(public_path('/../../assets/img/documents/'. $application->akte_kelahiran))) {
                    File::delete(public_path('/../../assets/img/documents/'. $application->akte_kelahiran));
                }

                // $file->move(public_path('assets/img/documents'), $name_file);

                // hosting
                $file->move(public_path('/../../public_html/assets/img/documents'), $name_file);

                $application->update([
                    'akte_kelahiran' => $name_file,
                    'akte_kelahiran_time' => Carbon::now(),
                ]);

                break;

            case 'kartu_keluarga':
                // if (File::exists(public_path('assets/img/documents/'. $application->kartu_keluarga))) {
                //     File::delete(public_path(). '/assets/img/documents/'.$application->kartu_keluarga);
                // }

                // hosting
                if (File::exists(public_path('/../../assets/img/documents/'. $application->kartu_keluarga))) {
                    File::delete(public_path('/../../assets/img/documents/'. $application->kartu_keluarga));
                }

                // $file->move(public_path('assets/img/documents'), $name_file);

                // hosting
                $file->move(public_path('/../../public_html/assets/img/documents'), $name_file);

                $application->update([
                    'kartu_keluarga' => $name_file,
                    'kartu_keluarga_time' => Carbon::now(),
                ]);

                break;

            case 'ktp_ayah':
                // if (File::exists(public_path('assets/img/documents/'. $application->ktp_ayah))) {
                //     File::delete(public_path(). '/assets/img/documents/'.$application->ktp_ayah);
                // }

                // hosting
                if (File::exists(public_path('/../../assets/img/documents/'. $application->ktp_ayah))) {
                    File::delete(public_path('/../../assets/img/documents/'. $application->ktp_ayah));
                }

                // $file->move(public_path('assets/img/documents'), $name_file);

                // hosting
                $file->move(public_path('/../../public_html/assets/img/documents'), $name_file);

                $application->update([
                    'ktp_ayah' => $name_file,
                    'ktp_ayah_time' => Carbon::now(),
                ]);

                break;
            case 'ktp_ibu':
                // if (File::exists(public_path('assets/img/documents/'. $application->ktp_ibu))) {
                //     File::delete(public_path(). '/assets/img/documents/'.$application->ktp_ibu);
                // }

                // hosting
                if (File::exists(public_path('/../../assets/img/documents/'. $application->ktp_ibu))) {
                    File::delete(public_path('/../../assets/img/documents/'. $application->ktp_ibu));
                }

                // $file->move(public_path('assets/img/documents'), $name_file);

                // hosting
                $file->move(public_path('/../../public_html/assets/img/documents'), $name_file);

                $application->update([
                    'ktp_ibu' => $name_file,
                    'ktp_ibu_time' => Carbon::now(),
                ]);

                break;
            case 'ijazah':
                // if (File::exists(public_path('assets/img/documents/'. $application->ijazah))) {
                //     File::delete(public_path(). '/assets/img/documents/'.$application->ijazah);
                // }

                // hosting
                if (File::exists(public_path('/../../assets/img/documents/'. $application->ijazah))) {
                    File::delete(public_path('/../../assets/img/documents/'. $application->ijazah));
                }

                // $file->move(public_path('assets/img/documents'), $name_file);

                // hosting
                $file->move(public_path('/../../public_html/assets/img/documents'), $name_file);

                $application->update([
                    'ijazah' => $name_file,
                    'ijazah_time' => Carbon::now(),
                ]);

                break;
        }

        return redirect()->back();
    }
}
