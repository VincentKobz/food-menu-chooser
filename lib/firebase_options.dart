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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD0BB-pZQxrFLhoca8EBbaahR764tU6OeY',
    appId: '1:580053485936:web:d3acbbc774e7d1ba9ba7b5',
    messagingSenderId: '580053485936',
    projectId: 'sushi-f8d33',
    authDomain: 'sushi-f8d33.firebaseapp.com',
    storageBucket: 'sushi-f8d33.appspot.com',
    measurementId: 'G-E4YGR5PL4H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgFJrzvhkh6ZBGfsUFucBKQD20U12-Lik',
    appId: '1:580053485936:android:0eaafff854a3312f9ba7b5',
    messagingSenderId: '580053485936',
    projectId: 'sushi-f8d33',
    storageBucket: 'sushi-f8d33.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAT5DG8CLoqu-K1bI8n_hS_9teDIKTlGo',
    appId: '1:580053485936:ios:4412f5f24478ccbb9ba7b5',
    messagingSenderId: '580053485936',
    projectId: 'sushi-f8d33',
    storageBucket: 'sushi-f8d33.appspot.com',
    iosClientId: '580053485936-t79sa19fjtk48k62fgrls6c8gcgpblk0.apps.googleusercontent.com',
    iosBundleId: 'com.example.sushi',
  );
}
