// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions android = FirebaseOptions( 
    apiKey: 'AIzaSyDS2L1WC1HHMc3PPf64ZN0D-TYGILhYIOE',
    appId: '1:763655628817:android:9a3b08a14fd897d64aa9b0',
    messagingSenderId: '763655628817',
    projectId: 'logaluxe-8c36e',
    storageBucket: 'logaluxe-8c36e.firebasestorage.app',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBAPPp-4OXAuEMHw6q7mmguYHk0FdeMVVc',
    appId: '1:763655628817:ios:568287125d8091074aa9b0',
    messagingSenderId: '763655628817',
    projectId: 'logaluxe-8c36e',
    storageBucket: 'logaluxe-8c36e.firebasestorage.app',
    iosClientId: '763655628817-ra1ldjba8m7agp1bpvb39pci2bhrqsl3.apps.googleusercontent.com',
    iosBundleId: 'com.example.logaluxeUsers',
  );
}
