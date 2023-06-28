<?php
namespace App\Traits;

trait ApiResponser
{
    protected function success($data, $message = null, int $code = 200)
    {
        return response()->json([
            'status' => 'Success',
            'message' => $message,
            'data' => $data,
        ], $code);
    }

    protected function error($message, $data = null, int $code = 409)
    {
        return response()->json([
            'status' => 'Error',
            'message' => $message,
            'errors' => $data,
        ], $code);
    }
}
