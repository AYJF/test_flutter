import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_apk/app.dart';
import 'package:test_apk/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  // https://firebase.flutter.dev/docs/overview/
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return ShowError(errorText: snapshot.error.toString());
        }

        // Once complete, show main application.
        if (snapshot.connectionState == ConnectionState.done) {
          return WarmtePortaalApp();
        }

        // Otherwise, waiting for initialization to complete.
        return ShowLoading();
      },
    );
  }
}

class ShowError extends StatelessWidget {
  final String? errorText;

  const ShowError({Key? key, this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Text(
        errorText ?? " ",
        textDirection: TextDirection.ltr,
        style: TextStyle(fontSize: 30.0, color: Colors.red),
      ),
    );
  }
}

class ShowLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
