import 'package:chatapp/pages/login.dart';
import 'package:chatapp/pages/signup.dart';
import 'package:flutter/material.dart';

class Login_Signup extends StatefulWidget {
  const Login_Signup({super.key});

  @override
  State<Login_Signup> createState() => _Login_SignupState();
}

class _Login_SignupState extends State<Login_Signup> {
  bool showlogin = true;

  void togglePages() {
    setState(() {
      showlogin = !showlogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showlogin){
      return Login(onTap: togglePages);
    }
    else{
      return SignUp(onTap: togglePages);
    }
  }
}
