package org.voiddog.ffmpeg.test;

import android.Manifest;
import android.content.pm.PackageManager;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import org.voiddog.ffmpeg.FFmpegNativeBridge;

public class MainActivity extends AppCompatActivity {

    private static final int REQUEST_PERMISSION = 100;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        FFmpegNativeBridge.setDebug(true);
    }

    public void doCompress(View view) {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED
                || ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED){
            ActivityCompat.requestPermissions(this, new String[]{
                    Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE
            }, REQUEST_PERMISSION);
        } else {
            // test compress time
            // you need replace to your source
            long startTime = System.currentTimeMillis();
            int ret = FFmpegNativeBridge.runCommand(new String[]{"ffmpeg",
                    "-i", "/storage/emulated/0/AzRecorderFree/2017_10_13_14_57_59.mp4",
                    "-y",
                    "-c:v", "libx264",
                    "-c:a", "aac",
                    "-vf", "scale=-2:640",
                    "-preset", "ultrafast",
                    "-b:v", "450k",
                    "-b:a", "96k",
                    "/storage/emulated/0/Download/a.mp4"});
            System.out.println("ret: " + ret + ", time: " + (System.currentTimeMillis() - startTime));
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        if (requestCode == REQUEST_PERMISSION){
            doCompress(null);
        }
    }
}
