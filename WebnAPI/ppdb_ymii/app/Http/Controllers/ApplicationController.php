<?php

namespace App\Http\Controllers;

use App\Models\Application;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Response;

class ApplicationController extends Controller
{
    // Pilih Aplikasi
    public function pilih_aplikasi()
    {
        return view('pages.profile.pilih_aplikasi');
    }

    public function pilih_aplikasi_action(Request $request)
    {
        $data = $request->all();

        $data['user_id'] = Auth::user()->id;

        Application::create($data);

        return redirect()->route('dashboard');
    }

    // Budget
    public function pay($username)
    {
        $user = $this->admin_access($username);

        return view('pages.application.pay', [
            'user' => $user,
        ]);
    }

    public function pay_proses(Request $request, $username)
    {
        $user = $this->admin_access($username);

        $request->validate([
            'photo' => 'required|image|mimes:png,jpg,jpeg,pdf',
        ]);

        $file = $request->file('photo');

        $application = Application::where('user_id', $user->id)->first();

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

        return redirect()->back();
    }


    // Akte Kelahiran
    public function ak($username)
    {
        $user = $this->admin_access($username);

        return view('pages.application.ak', [
            'user' => $user,
        ]);
    }

    public function ak_proses(Request $request, $username)
    {
        $user = $this->admin_access($username);

        $request->validate([
            'photo' => 'required|image|mimes:png,jpg,jpeg,pdf',
        ]);

        $file = $request->file('photo');

        $application = Application::where('user_id', $user->id)->first();

        if (File::exists(public_path('assets/img/documents/'. $application->akte_kelahiran))) {
            File::delete(public_path(). '/assets/img/documents/'.$application->akte_kelahiran);
        }

        // hosting
        // if (File::exists(public_path('/../../assets/img/documents/'. $application->akte_kelahiran))) {
        //     File::delete(public_path('/../../assets/img/documents/'. $application->akte_kelahiran));
        // }

        $name_file = time().'.'.$file->getClientOriginalExtension();

        $file->move(public_path('assets/img/documents'), $name_file);

        // hosting
        // $file->move(public_path('/../../public_html/assets/img/documents'), $name_file);

        $application->update([
            'akte_kelahiran' => $name_file,
            'akte_kelahiran_time' => Carbon::now(),
        ]);

        return redirect()->back();
    }

    // Kartu Keluarga
    public function kk($username)
    {
        $user = $this->admin_access($username);

        return view('pages.application.kk', [
            'user' => $user,
        ]);
    }

    public function kk_proses(Request $request, $username)
    {
        $user = $this->admin_access($username);

        $request->validate([
            'photo' => 'required|image|mimes:png,jpg,jpeg,pdf',
        ]);

        $file = $request->file('photo');

        $application = Application::where('user_id', $user->id)->first();

        if (File::exists(public_path('assets/img/documents/'. $application->kartu_keluarga))) {
            File::delete(public_path(). '/assets/img/documents/'.$application->kartu_keluarga);
        }

        // hosting
        // if (File::exists(public_path('/../../assets/img/documents/'. $application->kartu_keluarga))) {
        //     File::delete(public_path('/../../assets/img/documents/'. $application->kartu_keluarga));
        // }

        $name_file = time().'.'.$file->getClientOriginalExtension();

        $file->move(public_path('assets/img/documents'), $name_file);

        // hosting
        // $file->move(public_path('/../../public_html/assets/img/documents'), $name_file);

        $application->update([
            'kartu_keluarga' => $name_file,
            'kartu_keluarga_time' => Carbon::now(),
        ]);

        return redirect()->back();
    }

    // KTP ayah
    public function ka($username)
    {
        $user = $this->admin_access($username);

        return view('pages.application.ka', [
            'user' => $user,
        ]);
    }

    public function ka_proses(Request $request, $username)
    {
        $user = $this->admin_access($username);

        $request->validate([
            'photo' => 'required|image|mimes:png,jpg,jpeg,pdf',
        ]);

        $file = $request->file('photo');

        $application = Application::where('user_id', $user->id)->first();

        if (File::exists(public_path('assets/img/documents/'. $application->ktp_ayah))) {
            File::delete(public_path(). '/assets/img/documents/'.$application->ktp_ayah);
        }

        // hosting
        // if (File::exists(public_path('/../../assets/img/documents/'. $application->ktp_ayah))) {
        //     File::delete(public_path('/../../assets/img/documents/'. $application->ktp_ayah));
        // }

        $name_file = time().'.'.$file->getClientOriginalExtension();

        $file->move(public_path('assets/img/documents'), $name_file);

        // hosting
        // $file->move(public_path('/../../public_html/assets/img/documents'), $name_file);

        $application->update([
            'ktp_ayah' => $name_file,
            'ktp_ayah_time' => Carbon::now(),
        ]);

        return redirect()->back();
    }

    // KTP Ibu
    public function ki($username)
    {
        $user = $this->admin_access($username);

        return view('pages.application.ki', [
            'user' => $user,
        ]);
    }

    public function ki_proses(Request $request, $username)
    {
        $user = $this->admin_access($username);

        $request->validate([
            'photo' => 'required|image|mimes:png,jpg,jpeg,pdf',
        ]);

        $file = $request->file('photo');

        $application = Application::where('user_id', $user->id)->first();

        if (File::exists(public_path('assets/img/documents/'. $application->ktp_ibu))) {
            File::delete(public_path(). '/assets/img/documents/'.$application->ktp_ibu);
        }

        // hosting
        // if (File::exists(public_path('/../../assets/img/documents/'. $application->ktp_ibu))) {
        //     File::delete(public_path('/../../assets/img/documents/'. $application->ktp_ibu));
        // }

        $name_file = time().'.'.$file->getClientOriginalExtension();

        $file->move(public_path('assets/img/documents'), $name_file);

        // hosting
        // $file->move(public_path('/../../public_html/assets/img/documents'), $name_file);

        $application->update([
            'ktp_ibu' => $name_file,
            'ktp_ibu_time' => Carbon::now(),
        ]);

        return redirect()->back();
    }

    // KTP Ibu
    public function it($username)
    {
        $user = $this->admin_access($username);

        return view('pages.application.it', [
            'user' => $user,
        ]);
    }

    public function it_proses(Request $request, $username)
    {
        $user = $this->admin_access($username);

        $request->validate([
            'photo' => 'required|image|mimes:png,jpg,jpeg,pdf',
        ]);

        $file = $request->file('photo');

        $application = Application::where('user_id', $user->id)->first();

        if (File::exists(public_path('assets/img/documents/'. $application->ijazah_terakhir))) {
            File::delete(public_path(). '/assets/img/documents/'.$application->ijazah_terakhir);
        }

        // hosting
        // if (File::exists(public_path('/../../assets/img/documents/'. $application->ijazah_terakhir))) {
        //     File::delete(public_path('/../../assets/img/documents/'. $application->ijazah_terakhir));
        // }

        $name_file = time().'.'.$file->getClientOriginalExtension();

        $file->move(public_path('assets/img/documents'), $name_file);

        // hosting
        // $file->move(public_path('/../../public_html/assets/img/documents'), $name_file);

        $application->update([
            'ijazah_terakhir' => $name_file,
            'ijazah_terakhir_time' => Carbon::now(),
        ]);

        return redirect()->back();
    }

    // Admin
    public function admin_access($un)
    {
        if (Auth::user()->role == 'admin') {
            $user = User::with(['Application'])->where('username', $un)->first();
        } else {
            if (Auth::user()->username != $un) {
                return redirect()->back();
            }
            $user = User::with(['Application'])->findOrFail(Auth::user()->id);
        }

        return $user;
    }

    // // download
    // public function getDownload($file, $category)
    // {
    //     if ($category == 'pembayaran') {
    //         return Response::download(public_path('assets/img/bukti-pembayaran', $file), time().'-pembayaran');
    //     } else {
    //         return Response::download(public_path('assets/img/documents', $file), );
    //     }
    // }
}
