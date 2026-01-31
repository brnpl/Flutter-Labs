# Flutter Reverse Engineering Labs
This repository contains a series of progressive challenges designed to introduce the reverse engineering of Flutter applications. Since there aren't many blog posts or tutorials that explain Flutter reversing in detail, I decided to create this repo as a hands-on way to fill that gap.

The goal is to build a solid foundation for understanding the unique characteristics of the Flutter framework and the analysis techniques commonly used with it.

The challenges are structured incrementally, starting with fundamental concepts and advancing toward intermediate and more advanced techniques such as network traffic interception and protection bypasses.

Instead of a traditional writeup, each challenge includes a detailed, blog post-style solution that guides you step-by-step through the reversing process, blending hands-on problem-solving with relevant theory so the concepts are learned directly through practice.

## 📋 Prerequisites
- Basic knowledge of Android mobile applications
- Familiarity with reverse engineering concepts
- Familiarity with Frida
- Rooted Android device (some challenges may not function correctly on emulators)

If you feel you are missing any prerequisites, the following resources are highly recommended:
- [Android PT (HTB)](https://academy.hackthebox.com/path/preview/android-application-pentesting)
- [Mobile Hacking Lab](https://www.mobilehackinglab.com/)
- [Frida Android Labs](https://github.com/DERE-ad2001/Frida-Labs)

## 🎯 Challenge Structure
Each challenge directory includes:
- `chall<X>.apk`: the compiled APK for the challenge;
- `solution/_images/`: images referenced in the solution;
- `solution/solution.md`: a detailed, step-by-step solution;
- `source/`: the application source files and the build instructions, for those who want to modify the app and experiment further;

```
$ tree
.
├── chall<X>.apk
├── solution
│   ├── _images
│   │   ├── chall<X_Y>.png
│   └── solution.md
└── src
    ├── how_to_build.md
    └── main.dart
```

## 🚀 Challenges Overview
- [chall0](./chall0/): Introduction to Flutter
- [chall1](./chall1/): Debug Mode - Source Code Leakage
- [chall2](./chall2/): Release Mode - Finding Hardcoded Secrets
- [chall3](./chall3/): Release Mode - Hooking with Frida 1 (read return value)
- [chall4](./chall4/): Release Mode - Hooking with Frida 2 (change return value)
- [chall5](./chall5/): Release Mode - Reversing Platform (Java) Code
- [chall6](./chall6/): Release Mode - Intercepting HTTPS Traffic
- [chall7](./chall7/): Release Mode - Bypassing Integrity Checks for Traffic Interception
- [chall8](./chall8/): Release Mode - Bypassing SSL Pinning

## 🛠️ Tools Used
Some of these tools require specific configurations. To simplify setup and ensure reproducibility, Dockerfiles are provided for some of these tools and can be found in the `/tools` directory.

Tools:
- `apktool` - Tool for decompiling and rebuilding APKs ([link](https://apktool.org/))
- `Blutter` - Decompiler for Flutter applications ([link](https://github.com/worawit/blutter), [Dockerfile included in this repository](./tools/blutter/Dockerfile))
- `Frida` - Dynamic instrumentation toolkit ([link](https://frida.re/))
- `jadx` - Android decompiler ([link](https://github.com/skylot/jadx))
- `reFlutter` - Framework for Flutter reverse engineering ([link](https://github.com/Impact-I/reFlutter))
- `Burp Suite` - Proxy for traffic interception ([link](https://portswigger.net/burp))

## 📚 Further Resources
- [Flutter Official Website](https://flutter.dev/)
- [Frida Documentation](https://frida.re/)
- [Blutter GitHub Repository](https://github.com/worawit/blutter)
- [reFlutter GitHub Repository](https://github.com/Impact-I/reFlutter)
- [The Complexity Of Reversing Flutter Applications by Axelle Apvrille (youtube)​](https://www.youtube.com/watch?v=JNoEUPlgcZk)
- [Flutter Hackers: Uncovering the Dev’s Myopia (Part 1)​](https://infosecwriteups.com/flutter-hackers-uncovering-the-devs-myopia-part-1-6c316be56b13)
- [Flutter Hackers: Uncovering the Dev’s Myopia (Part 2)​](https://infosecwriteups.com/flutter-hackers-uncovering-the-devs-myopia-part-2-598a44942b5e)
- [Reversing an Android sample which uses Flutter​](https://cryptax.medium.com/reversing-an-android-sample-which-uses-flutter-23c3ff04b847)
- [The Current State & Future of Reversing Flutter Apps​](https://www.guardsquare.com/blog/current-state-and-future-of-reversing-flutter-apps)
- [Obstacles in Dart Decompilation & the Impact on Flutter App Security​](https://www.guardsquare.com/blog/obstacles-in-dart-decompilation-and-the-impact-on-flutter-app-security)
- [How Classical Attacks Apply to Flutter Apps​](https://www.guardsquare.com/blog/how-classical-attacks-apply-to-flutter-apps)
- [B(l)utter - Reversing Flutter Application by using Dart Runtime​](https://conference.hitb.org/hitbsecconf2023hkt/materials/D2%20COMMSEC%20-%20B(l)utter%20%E2%80%93%20Reversing%20Flutter%20Applications%20by%20using%20Dart%20Runtime%20-%20Worawit%20Wangwarunyoo.pdf)
- [Intercepting traffic from Android Flutter applications​](https://blog.nviso.eu/2019/08/13/intercepting-traffic-from-android-flutter-applications/)
- [Intercept Flutter traffic on iOS and Android (HTTP/HTTPS/Dio Pinning)​](https://blog.nviso.eu/2022/08/18/intercept-flutter-traffic-on-ios-and-android-http-https-dio-pinning/)
- [Blog frida-flutterproxy](https://hackcatml.tistory.com/197)
- [Intercepting HTTPS Communication in Flutter](https://sensepost.com/blog/2025/intercepting-https-communication-in-flutter-going-full-hardcore-mode-with-frida/)

## 📝 License
This project is distributed under the MIT License. See the [LICENSE](./LICENSE) file for more details.

## ⚠️ Disclaimer
This repository is created exclusively for educational purposes. The techniques described should only be used on applications for which you have the right to analyze or in controlled test environments. The author assumes no responsibility for misuse of the information contained in this repository.
