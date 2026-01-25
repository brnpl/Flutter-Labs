package com.flutter_labs.chall5;

import android.os.Bundle;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import com.scottyab.rootbeer.RootBeer;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "root_check_channel";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("isRooted")) {
                        RootBeer rootBeer = new RootBeer(this);
                        boolean isRooted = rootBeer.isRooted();
                        result.success(isRooted);
                    } else {
                        result.notImplemented();
                    }
                }
            );
    }
}