// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDKxWJqUtyGkHwZyQGfJfdGSVKu1flnKzw',
    appId: '1:125943464984:web:e3ea94f718f8ac94b3af6d',
    messagingSenderId: '125943464984',
    projectId: 'chatapp-75457',
    authDomain: 'chatapp-75457.firebaseapp.com',
    storageBucket: 'chatapp-75457.firebasestorage.app',
    measurementId: 'G-JC1H73MLGL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZrz6JQ-eVu-sUfPfZJq7vqQknocUyX44',
    appId: '1:125943464984:android:88a5109d82f5eb44b3af6d',
    messagingSenderId: '125943464984',
    projectId: 'chatapp-75457',
    storageBucket: 'chatapp-75457.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfz1LrUhJlz8p0DBFB1mT1VYYOlNmOOJw',
    appId: '1:125943464984:ios:6694d6a73ee00526b3af6d',
    messagingSenderId: '125943464984',
    projectId: 'chatapp-75457',
    storageBucket: 'chatapp-75457.firebasestorage.app',
    iosBundleId: 'com.example.practice',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDfz1LrUhJlz8p0DBFB1mT1VYYOlNmOOJw',
    appId: '1:125943464984:ios:6694d6a73ee00526b3af6d',
    messagingSenderId: '125943464984',
    projectId: 'chatapp-75457',
    storageBucket: 'chatapp-75457.firebasestorage.app',
    iosBundleId: 'com.example.practice',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDKxWJqUtyGkHwZyQGfJfdGSVKu1flnKzw',
    appId: '1:125943464984:web:8cef2d3d658ad708b3af6d',
    messagingSenderId: '125943464984',
    projectId: 'chatapp-75457',
    authDomain: 'chatapp-75457.firebaseapp.com',
    storageBucket: 'chatapp-75457.firebasestorage.app',
    measurementId: 'G-W0FL33XKMW',
  );
}
