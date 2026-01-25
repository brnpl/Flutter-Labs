# How to build
### 1. Create Flutter Project
```shell
$ flutter create chall8
```

### 2. Replace `main.dart`
Substitute `lib/main.dart` with the provided [main.dart](main.dart).

If you change the target host, make sure to update the pinned certificate by regenerating its SHA-256 fingerprint:
```shell
openssl s_client -connect raw.githubusercontent.com:443 < /dev/null 2>/dev/null | openssl x509 -fingerprint -sha256 -noout
```


### 3. Add dependencies in `pubspec.yaml`
Add `http`, `http_certificate_pinning` and `dio` in `pubspec.yaml`.

**File:** `pubspec.yaml`
```yaml
...
dependencies:
  flutter:
    sdk: flutter

  http: ^1.1.0
  http_certificate_pinning: ^3.0.1
  dio: ^5.4.0
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