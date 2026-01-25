# How to build
### 1. Create Flutter Project
```shell
$ flutter create chall7
```

### 2. Replace `main.dart`
Substitute `lib/main.dart` with the provided [main.dart](main.dart). 

### 3. Create folder structure for `MainActivity.java`
By default, the application package name is `com.example.chall7` (if you used the command in 1.). If you want to rebuild the app using `com.flutter_labs.chall7`, you must update all occurrences of the package name in the code accordingly.

For the Android layer, create the directory structure `com/flutter_labs/chall7` under `android/app/src/main/java` and place [MainActivity.java](./MainActivity.java) (note the package name) inside it. 

If the project fails to compile, remove the Kotlin entry point located at `android/app/src/main/kotlin/com/flutter_labs/chall7/MainActivity.kt` to avoid conflicts.

The resulting structure should look like this:
```shell
/android/app/src/main/java $ tree
.
├── com
│   └── flutter_labs
│       └── chall7
│           └── MainActivity.java
└── io
    └── flutter
        └── plugins
            └── GeneratedPluginRegistrant.java

6 directories, 2 files
```

### 4. Add `http` dependency in `pubspec.yaml`
Add `http: ^1.2.0` in `pubspec.yaml`.

**File:** `pubspec.yaml`
```yaml
...
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.8
  http: ^1.2.0
...
```

### 5. Enable internet access in `AndroidManifest.xml`
Add both `<uses-permission>` entries in your manifest to enable network access.

**File:** `android/app/src/main/AndroidManifest.xml` 
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
...
```

### 6. Build and Run
```shell
$ flutter build apk --release

$ flutter run
```