# How to build
### 1. Create Flutter Project
```shell
$ flutter create chall9
```

### 2. Replace `main.dart`
Substitute `lib/main.dart` with the provided [main.dart](main.dart).

### 3. Add dependencies in `pubspec.yaml`
Add `root_jailbreak_sniffer` in `pubspec.yaml`.

**File:** `pubspec.yaml`
```yaml
...
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.8
  root_jailbreak_sniffer: ^1.1.4
...
```

### 4. Build and Run
```shell
$ flutter build apk --release

$ flutter run
```