import 'package:chatapp/pages/homepage.dart';
import 'package:chatapp/pages/login_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){
          if (snapshot.hasData){
            return HomePage();
          }
          else {
           return Login_Signup(); 
          }
        })
    );
  }
}