# How to build
### 1. Create Flutter Project
```shell
$ flutter create chall6
```

### 2. Replace `main.dart`
Substitute `lib/main.dart` with the provided [main.dart](main.dart).

### 3. Add `http` dependency in `pubspec.yaml`
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

### 4. Enable internet access in `AndroidManifest.xml`
Add both `<uses-permission>` entries in your manifest to enable network access.

**File:** `android/app/src/main/AndroidManifest.xml` 
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
...
```

### 5. Build and Run
```shell
$ flutter build apk --release

$ flutter run
```