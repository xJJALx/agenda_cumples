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
    apiKey: 'AIzaSyBq2pe3_sQ2ZAJb5ehSoYuaCKXLc0k0UDs',
    appId: '1:666245894893:web:bad2e767c33368c11a72e4',
    messagingSenderId: '666245894893',
    projectId: 'xagenda-cumplesx',
    authDomain: 'xagenda-cumplesx.firebaseapp.com',
    storageBucket: 'xagenda-cumplesx.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACBQ-XkfuE9jM2xNYrbZmJNxS9-_hjYfA',
    appId: '1:666245894893:android:b7db8d75e730cef71a72e4',
    messagingSenderId: '666245894893',
    projectId: 'xagenda-cumplesx',
    storageBucket: 'xagenda-cumplesx.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_9f9hyBY_ML_fv6eXEEhHe5r4z-FanVA',
    appId: '1:666245894893:ios:e6b6d2991d88a89a1a72e4',
    messagingSenderId: '666245894893',
    projectId: 'xagenda-cumplesx',
    storageBucket: 'xagenda-cumplesx.appspot.com',
    iosClientId: '666245894893-dnrhldbkf5df315c33lmf8r5blgv02fn.apps.googleusercontent.com',
    iosBundleId: 'com.example.agendaCumples',
  );
}