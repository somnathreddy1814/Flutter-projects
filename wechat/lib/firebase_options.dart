// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAoiTH2I3jENpvdRuyZ7lZiXUZ6CqrePnE',
    appId: '1:262017653989:web:364942b95d39533473c80c',
    messagingSenderId: '262017653989',
    projectId: 'wechat-53aa3',
    authDomain: 'wechat-53aa3.firebaseapp.com',
    storageBucket: 'wechat-53aa3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADibFNEw4zV0JbCDUwWeoe233ym9lvcAs',
    appId: '1:262017653989:android:e2697b17cdef1ce373c80c',
    messagingSenderId: '262017653989',
    projectId: 'wechat-53aa3',
    storageBucket: 'wechat-53aa3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCWAa4rpkYIs-lfDEcrkLwt2sSa2R9Rz0M',
    appId: '1:262017653989:ios:5b6d741d739857f273c80c',
    messagingSenderId: '262017653989',
    projectId: 'wechat-53aa3',
    storageBucket: 'wechat-53aa3.appspot.com',
    iosBundleId: 'com.example.wechat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCWAa4rpkYIs-lfDEcrkLwt2sSa2R9Rz0M',
    appId: '1:262017653989:ios:85d95f3628c06c9c73c80c',
    messagingSenderId: '262017653989',
    projectId: 'wechat-53aa3',
    storageBucket: 'wechat-53aa3.appspot.com',
    iosBundleId: 'com.example.wechat.RunnerTests',
  );
}
