# Challenge 0: Introduction to Flutter
Welcome to Flutter Labs! Before diving into the challenges, it's essential to understand what Flutter is and how it works.

## What is Flutter?
Flutter is Google's open-source UI framework for building **natively compiled applications** for mobile, web, and desktop from a single codebase. Released in 2017 and reaching stable version 1.0 in December 2018, Flutter has rapidly gained popularity across the developer community.

At its core, Flutter promises "write once, run anywhere". Developers write their application logic in `Dart` (Google's programming language) and construct user interfaces using Flutter's extensive widget system. The same codebase can then be compiled to run on Android, iOS, web browsers, Windows, macOS, and Linux.

Flutter's popularity is driven by several key features:
- Hot Reload, which allows developers to see changes instantly without restarting the app;
- A rich and highly customizable widget ecosystem;
- Near-native performance, achieved through Ahead-of-Time (AOT) compilation to native machine code;
- A single shared codebase, dramatically reducing development time and maintenance costs;

## Flutter Architecture
To understand why Flutter apps feel "different" when reversing them, it helps to compare Flutter's architecture with traditional platform native development.

### Traditional Platform Native Development
In traditional mobile development, applications are tightly coupled to their platforms. Android applications are primarily written in Java or Kotlin, compiled into Dalvik Executable (DEX) bytecode that runs on the Android Runtime. The UI is defined using XML layout files, and the logic is contained in Java or Kotlin classes.

When reverse engineering Android apps, the DEX bytecode can be decompiled back into reasonably readable Java code using tools like JADX. The application structure is straightforward with Activities, Services, XML layouts, and resources that are all clearly separated and identifiable.

### Flutter's Different Approach
Flutter takes a fundamentally different approach. Instead of relying on native UI components, Flutter uses its own rendering engine (Skia) to draw every pixel on the screen. Both the UI and application logic live entirely in Dart.

A Flutter application consists of three primary layers:
- The Dart Layer is where your application code lives, including app logic, widget definitions, state management, and business logic, with the main entry point typically in `lib/main.dart`;
- The Flutter Engine is a C++ engine that handles low-level rendering, text layout, file and network I/O, and includes the Dart runtime providing the bridge between your Dart code and the underlying platform;
- The Platform Layer is the thin native layer (Java/Kotlin on Android, Swift/Objective-C on iOS) that handles platform-specific functionality like accessing camera, sensors, and other native APIs;

When you build a Flutter app, the compilation process differs significantly based on the build mode. In **Debug Mode**, the Dart code is compiled to an intermediate format called Dart kernel bytecode, stored in `kernel_blob.bin`. This file retains much of the original code structure, including class names, method names, and even comments. In **Release Mode**, the Dart code undergoes Ahead-of-Time (AOT) compilation, transforming it into native machine code stored in `libapp.so`. This compiled library is platform-specific and highly optimized.

## Setting Up Your Environment

### Installing Flutter
Even though the focus is on reverse engineering rather than development, having Flutter installed is useful for building sample apps and understanding the compilation process. 

**This is an important consideration because some tools and techniques may not work correctly with newer Flutter and Dart releases**. 

These challenges were created and tested with Flutter 3.32.5 using Dart 3.8.1, and differences in versions may affect reproducibility and analysis results.
```shell
$ flutter --version
Flutter 3.32.5 • channel stable • https://github.com/flutter/flutter.git
Framework • revision fcf2c11572 (7 months ago) • 2025-06-24 11:44:07 -0700
Engine • revision dd93de6fb1 (7 months ago) • 2025-06-24 07:39:37 -0700
Tools • Dart 3.8.1 • DevTools 2.45.1
```

While newer versions should work, using the same version ensures consistency.

You can install Flutter by following the official guide at https://docs.flutter.dev/get-started/install.

After installation, verify it by running `flutter doctor`.

### Installing Frida
Frida is a dynamic instrumentation toolkit used extensively from [chall3](../chall3/) onwards. It allows injecting JavaScript code into running applications to hook functions, inspect memory, and modify application behavior in real-time.

Note that your Android device must be rooted to run `frida-server`.

Install Frida tools on your computer:
```shell
$ python3 -m pip install 'frida==<version>' 'frida-tools==<version>'
```

Example versions used in this environment:
```shell
$ pip3 show frida
Name: frida
Version: 16.7.13
...

$ pip3 show frida-tools
Name: frida-tools
Version: 13.7.1
Summary: Frida CLI tools
...
```

Next, download the matching `frida-server` binary for your Android architecture from the official [GitHub releases page](https://github.com/frida/frida/releases), extract it, and push it to your device.

For ARM architecture, you can directly use `https://github.com/frida/frida/releases/download/<version>/frida-server-<version>-android-arm64.xz`.

Extract the Frida server binary, push it to the device, set the appropriate permissions, and start the service:
```shell
$ unxz frida-server-<version>-android-arm64.xz

$ adb push frida-server-<version>-android-arm64 /data/local/tmp/frida-server

$ adb shell "chmod 755 /data/local/tmp/frida-server"

$ adb shell "su -c /data/local/tmp/frida-server &"
```

Once running, verify that Frida can see your device:
```shell
$ frida-ps -U
```

### Traffic Interception
Starting from [chall6](../chall6/), intercepting and analyzing HTTPS traffic becomes necessary.

The basic setup involves installing Burp Suite on your computer, configuring your Android device to use Burp as a proxy, and installing Burp's CA certificate on your Android device. Detailed instructions for setting up Burp Suite with Android can be found in the [PortSwigger Blog Post](https://portswigger.net/burp/documentation/desktop/mobile/config-android-device).

### Why Flutter Reverse Engineering Matters
As Flutter continues to grow in popularity, more applications, including those handling sensitive data, are being built with this framework. Understanding how to analyze Flutter applications is becoming an essential skill for security researchers identifying vulnerabilities, penetration testers assessing mobile app security and bug bounty hunters finding security issues.

The techniques covered in these challenges apply to real-world scenarios.