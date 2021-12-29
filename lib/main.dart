import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/app.dart';
import 'package:test_flutter/firebase_options.dart';
import 'package:test_flutter/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    /// Inject the [FirebaseAuthService]
    /// and provide a stream of [User]
    ///
    /// This needs to be above [MaterialApp]
    /// At the top of the widget tree, to
    /// accomodate for navigations in the app
    MultiProvider(
      providers: [
        Provider(
          create: (_) => FirebaseAuthService(),
        ),
        StreamProvider(
          initialData: null,
          create: (context) =>
              context.read<FirebaseAuthService>().onAuthStateChanged,
        ),
      ],
      child: const MyApp(),
    ),
  );
}
