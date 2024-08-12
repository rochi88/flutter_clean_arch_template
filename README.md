# flutter_clean_pro_temp

New Flutter project with clean archetechture

## Getting Started

1. **Get the template**

   Create your project using this repo by either:

   * On Github, click the `"Use this template" ` button, which will allow you to create your project using this repo as your baseline, or
   * Clone this repo to your local machine

2. **Install dependencies**

   Run `flutter pub get` to fetch dependencies.

3. **Application Bundle Name**

   Now to change your app's package name/bundle identifier in both Android and iOS manifests, run `flutter pub run change_app_package_name:main <com.new.package.name>`.

   * This step uses [change_app_package_name](https://pub.dev/packages/change_app_package_name), go give the package some love.

4. **Application Name**
   Next, you'll need to change your app's user-readable label - the `CFBundleName` and/or `CFBundleDisplayName` within the `Info.plist` (for iOS) and `android:label` field in your application node in `AndroidManifest.xml` (for Android).

   I'm afraid this step is manual; it would be cool if `change_app_package_name` could do this for you.

   **NOTE**: You'll also need to change your package `name` and `description` within `pubspec.yaml`

5. **App Icons**

   Then we'll auto-generate your app launcher icons using the [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) package.
   * Copy the image you want to make your launcher icons out of to `assets/icon/icon.png.`
   * Now run `flutter pub run flutter_launcher_icons`. This command will auto-generate Android and iOS launcher icons from the PNG file for the different DPIs and place them in their respective resource directories.

   **NOTE**: Check the [package documentation](https://pub.dev/packages/flutter_launcher_icons#book-guide) for more configuration options on generating launcher icons updating your `pubspec. yaml` accordingly.
   For example, you may want different icons for different platforms since Android allows you to use a transparent icon and iOS doesn't.
   However, the default configuration included in this template will be sufficient in most cases.

6. **Splash screen**

   We'll then generate native splash screens for both of our platforms which your app will display before loading is complete and for this, we'll use [flutter_native_splash](https://pub.dev/packages/flutter_native_splash).
   * Copy the image you want to be displayed at the center of your splash screen to `assets/splash/splash.png.`
   * To change the background color of your splash screen, go to your `pubspec.yaml` under `flutter_native_splash -> color` and put your preferred color code. The default is white.
   * Finally, run `flutter pub run flutter_native_splash:create` to generate your resources from the splash image and update your manifest files.

7. **Environment variables**

   We'll make use of [envied package](https://pub.dev/packages/envied) to load app configuration from `.env` files.
   This will allow us to easily switch between different app configurations when running the app under different environments like production, staging, or debug modes.

   All `.env` files can be placed in the root directory of your project. The
   To set up a new environment, create a new file with a `.env` extension (e.g. `.env` or `debug.env` or `staging.env`), then copy the contents of `.env-sample` and populate it as needed.

   The `lib/env.dart` file imports the environment variables into the app. Look at [the documentation](https://pub.dev/packages/envied#overview) to understand how to use the `envied` package. 

   To obfuscate and hide sensitive ENV variable use the `obfuscate` attribute like so: `@EnviedField(obfuscate: true)`.

   **NOTE:** All `.env` files (and `envied`'s `env.g.dart` file) are `.gitignored` by default since they may contain sensitive information such as paths, keys, and such
   To specify new env keys add them to the `.env-sample` file, which will be copied by other devs and the corresponding configuration will be provided

8. **Firebase Reporting**

   In this step, we are going to integrate different Firebase Reporting Tools into your app, including [Firebase Analytics](https://firebase.google.com/products/analytics), [Firebase Performance](https://firebase.google.com/products/performance/), and [Crashlytics](https://firebase.google.com/products/crashlytics/).

   * Create your Firebase project on the [Firebase Console](https://console.firebase.google.com/)
   * Download your `GoogleService-Info.plist` & `google-services.json` and drop them into their corresponding folders for iOS and Android. I've `.gitignore'd these files so that you won't, by any chance, have them checked into your VCS by mistake.
   * Well, that's it. You're done! No further configuration is needed; I've already done that for you.

   **NOTES:**
   * All the Firebase Services we're using in this project are free of charge - at least at the time of writing - so they will not attract any charges.
   * With this step, we'll also have integrated [Firebase Performance Monitoring](https://firebase.google.com/products/performance/) into your HTTP Client using [dio_firebase_performance](https://pub.dev/packages/dio_firebase_performance) which is a [Dio Interceptor](https://pub.dev/packages/dio#interceptors) that will measure the performance of all your HTTP calls and report the stats to Firebase.

9. **Generate custom lint**

   Run `dart run custom_lint`

10. **Start Development**
   Run `flutter pub get`
   Run `dart run build_runner build`
   Run `dart run build_runner watch` or `dart run build_runner watch --delete-conflicting-outputs`
   Run `flutter run`

11. **Deploying**

   Before releasing your Android app, make sure to sign it by:

   [Generate a Keystore file](https://flutter.dev/docs/deployment/android#create-a-keystore) if you don't already have one. If you have one, ignore this step and go to the next.

   Go to `android/key.properties` and include your Keystore path, alias, and password.

## Removing unwanted packages

If a package is not listed, then removing it from [pubspec.yaml](./pubspec.yaml) as well as all
imports and uses should be enough. This is required for removing every packages, the following
instructions are an addition to that.

#### Flutter Lints

Delete the [analysis_options.yaml](./analysis_options.yaml) file. As an alternative you can modify
the rules in this file or use a different package like [Lint](https://pub.dev/packages/lint).

#### Easy Localization

Remove the [assets/translations](./assets/translations) folder. Go
to [ios/Runner/Info.plist](./ios/Runner/Info.plist) and remove the following code:

```
<key>CFBundleLocalizations</key>
<array>
	<string>en</string>
   <string>bn</string>
</array>
```

#### Url Launcher

For iOS go to [ios/Runner/Info.plist](./ios/Runner/Info.plist) and remove the following code:

```
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>https</string>
  <string>http</string>
</array>
```

For Android you can take a look at this [Stackoverflow issue](https://stackoverflow.com/a/65082750)
for more information. Go
to [android/app/src/AndroidManifest.xml](./android/app/src/main/AndroidManifest.xml) and add the
following code:

```
<manifest [...]

    <application>
        [...]
    </application
    
    <queries>
        <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="https" />
        </intent>
    </queries>

</manifest>
```

## Packages used

This repository uses the following pub packages:

| Package                                                                     | Version | Usage                                          |
|-----------------------------------------------------------------------------|---------|------------------------------------------------|
| [change_app_package_name](https://pub.dev/packages/change_app_package_name) | ^2.4.9  | Changes app package name with a single command.|
| [Flutter Riverpod](https://pub.dev/packages/flutter_riverpod)               | ^2.4.9  | State management*                              |
| [Flutter Lints](https://pub.dev/packages/flutter_lints)                     | ^3.0.1  | Stricter linting rules                         |
| [Path Provider](https://pub.dev/packages/path_provider)                     | ^2.1.2  | Get the save path for Hive                     |
| [Flutter Displaymode](https://pub.dev/packages/flutter_displaymode)         | ^0.6.0  | Support high refresh rate displays             |
| [Easy Localization](https://pub.dev/packages/easy_localization)             | ^3.0.3  | Makes localization easy                        |
| [Hive](https://pub.dev/packages/hive)                                       | ^2.2.3  | Platform independent storage.                  |
| [Url Launcher](https://pub.dev/packages/url_launcher)                       | ^6.2.4  | Open urls in Browser                           |
| [FluentUI Icons](https://pub.dev/packages/fluentui_system_icons)            | ^0.2.2  | Microsoft's open source icon library           |

> \* Recommended to keep regardless of your project

* [change_app_package_name](https://pub.dev/packages/change_app_package_name) - Changes app package name with a single command. It makes the process very easy and fast.
* [dio](https://pub.dev/packages/dio) - The best HTTP Client for Flutter IMO. Reusable interceptors, amirite?
* [dio_http_cache](https://pub.dev/packages/dio_http_cache) - Dio interceptor to cache requests. It intercepts requests to
  respond with cached data or intercepts new remote responses to be cached. Very configurable.
* [dio_log](https://pub.dev/packages/dio_log) - It's a Dio Interceptor that presents your request & response logs within your app's UI
* [envied](https://pub.dev/packages/envied) - Load configuration from a `.env` file.
* [firebase_analytics](https://pub.dev/packages/firebase_analytics) - Flutter plugin for Google Analytics for Firebase, an app measurement solution that provides insight on app usage and user engagement on Android and iOS.
* [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics) - Flutter plugin for Firebase Crashlytics. It reports uncaught errors to the Firebase console.
* [firebase_performance](https://pub.dev/packages/firebase_performance) - Flutter plugin for Google Performance Monitoring for Firebase, an app measurement solution that monitors traces and HTTP/S network requests on Android and iOS.
* [firebase_performance_dio](https://pub.dev/packages/firebase_performance_dio) - Dio's Interceptor implementation that sends HTTP request metric data to Firebase.
* [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) - A command-line tool that simplifies the task of updating your Flutter app's launcher icon.
* [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) - Automatically generates native code for adding splash screens in Android and iOS. Customize with a specific platform, background color, and splash image.
* [freezed](https://pub.dev/packages/freezed) - Simple yet powerful code generator for immutable classes with all the good stuff like unions/pattern-matching/copy etc. Made by [Remi Rousselet](https://github.com/rrousselGit), the creator & maintainer of Provider. Can work with [json_serializable](https://pub.dev/packages/json_serializable) for all your `fromJson()` and `toJson()` needs.
* [go_router](https://pub.dev/packages/go_router) - This package builds on top of the Flutter framework's Router API and provides convenient URL-based APIs to navigate between different screens.
* [screenshots](https://pub.dev/packages/screenshots) - Screenshots is a standalone command line utility and package for capturing screenshot images for Flutter.
* [pretty_dio_logger](https://pub.dev/packages/pretty_dio_logger) - Dio interceptor that prettily prints to console HTTP requests and responses going through Dio
