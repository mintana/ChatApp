import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/pages/login.dart';
import 'package:chatapp/pages/login_signup.dart';
import 'package:chatapp/pages/signup.dart';
import 'package:chatapp/utilities/auth.dart';
import 'package:chatapp/utilities/authentication.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (context) => Auth(), 
      child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Authentication(),
    );
  }
}
