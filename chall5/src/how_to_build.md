# How to build
### 1. Create Flutter Project
```shell
$ flutter create chall5
```

### 2. Replace `main.dart`
Substitute `lib/main.dart` with the provided [main.dart](main.dart).

### 3. Create folder structure for `MainActivity.java`
By default, the application package name is `com.example.chall5` (if you used the command in 1.). If you want to rebuild the app using `com.flutter_labs.chall5`, you must update all occurrences of the package name in the code accordingly.

For the Android layer, create the directory structure `com/flutter_labs/chall5` under `android/app/src/main/java` and place [MainActivity.java](./MainActivity.java) (note the package name) inside it. 

If the project fails to compile, remove the Kotlin entry point located at `android/app/src/main/kotlin/com/flutter_labs/chall5/MainActivity.kt` to avoid conflicts.

The resulting structure should look like this:
```shell
/android/app/src/main/java $ tree
.
├── com
│   └── flutter_labs
│       └── chall5
│           └── MainActivity.java
└── io
    └── flutter
        └── plugins
            └── GeneratedPluginRegistrant.java

6 directories, 2 files
```
### 4. Import `RootBeer` dependencies and disable platform (Java) code obfuscation
**File:** `./chall5/android/app/build.gradle.kts`

```kts
android {
    namespace = "com.flutter_labs.chall5"
    ...

    // import rootbeer
    dependencies {
        implementation("com.scottyab:rootbeer-lib:0.1.0")
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            // disable minification and resource shrinking
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}
```

### 5. Build and Run
```shell
$ flutter build apk --release

$ flutter run
```

### 6. Enable again platform (Java) code obfuscation
Remove the `isMinifyEnabled` and `isShrinkResources` from `./chall5/android/app/build.gradle.kts` and rebuild to obtain `chall5+obf.apk`.