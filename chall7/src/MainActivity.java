package com.flutter_labs.chall7;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import java.io.File;
import java.io.FileInputStream;
import java.security.MessageDigest;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "integrity_check";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(
                flutterEngine.getDartExecutor().getBinaryMessenger(),
                CHANNEL
        ).setMethodCallHandler((call, result) -> {
            if (call.method.equals("checkFlutterIntegrity")) {
                result.success(checkLibFlutter());
            } else {
                result.notImplemented();
            }
        });
    }

    private boolean checkLibFlutter() {
        try {
            String libDir = getApplicationInfo().nativeLibraryDir;
            File flutterLib = new File(libDir, "libflutter.so");

            if (!flutterLib.exists()) {
                System.out.println("libflutter.so not found");
                return false;
            }

            String hash = sha256(flutterLib);

            System.out.println("libflutter.so SHA-256: " + hash);

            String expectedHash = "cbcd613d19791a34dc7886ce0cc3504e787fbcd8bf9bfea8d4c55f3bcba9ede1";

            return hash.equalsIgnoreCase(expectedHash);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    private String sha256(File file) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        FileInputStream fis = new FileInputStream(file);

        byte[] buffer = new byte[8192];
        int n;
        while ((n = fis.read(buffer)) > 0) {
            digest.update(buffer, 0, n);
        }
        fis.close();

        byte[] hash = digest.digest();
        StringBuilder hex = new StringBuilder();
        for (byte b : hash) {
            hex.append(String.format("%02x", b));
        }
        return hex.toString();
    }
}
