import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user/pages/home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase app
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '',
      routes: {
        '/' : (context) => const Home(),
      },
    );
  }
}
