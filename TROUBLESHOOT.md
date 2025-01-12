# TROUBLESHOOT

## Flutter: CocoaPods's specs repository is too out-of-date to satisfy dependencies
### solution

1. `flutter clean`
2. Delete `/ios/Pods`
3. Delete `/ios/Podfile.lock`
4. `flutter pub get`
5. from inside ios folder: `pod install`
6. `flutter run`