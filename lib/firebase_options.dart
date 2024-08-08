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
    apiKey: 'AIzaSyD9KjHUo4tdJZ9-D9fyi-FIONcZngW4UuY',
    appId: '1:849097158271:web:a6e3e7ef2176fff3fdd94a',
    messagingSenderId: '849097158271',
    projectId: 'chatapp-9d960',
    authDomain: 'chatapp-9d960.firebaseapp.com',
    storageBucket: 'chatapp-9d960.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWBANaklsZz6ThHANdq9QVWSZxWIBDF5M',
    appId: '1:849097158271:android:7584e49b00ed691bfdd94a',
    messagingSenderId: '849097158271',
    projectId: 'chatapp-9d960',
    storageBucket: 'chatapp-9d960.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCB4XONyIjBo3q9pjIrXAbtcT1DnqG3U_M',
    appId: '1:849097158271:ios:792a7dc5c2ef25c3fdd94a',
    messagingSenderId: '849097158271',
    projectId: 'chatapp-9d960',
    storageBucket: 'chatapp-9d960.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCB4XONyIjBo3q9pjIrXAbtcT1DnqG3U_M',
    appId: '1:849097158271:ios:792a7dc5c2ef25c3fdd94a',
    messagingSenderId: '849097158271',
    projectId: 'chatapp-9d960',
    storageBucket: 'chatapp-9d960.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD9KjHUo4tdJZ9-D9fyi-FIONcZngW4UuY',
    appId: '1:849097158271:web:9d0a6bb1de7b9ec3fdd94a',
    messagingSenderId: '849097158271',
    projectId: 'chatapp-9d960',
    authDomain: 'chatapp-9d960.firebaseapp.com',
    storageBucket: 'chatapp-9d960.appspot.com',
  );
}
