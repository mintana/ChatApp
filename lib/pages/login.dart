// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chatapp/components/textfield.dart';
import 'package:chatapp/utilities/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hidden = true;
  TextEditingController EmailController = TextEditingController();
  TextEditingController PassController = TextEditingController();

  void login() async {
    final auth = Provider.of<Auth>(context, listen: false);

    try {
      await auth.signInWithEmailAndPassword(EmailController.text, PassController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 232, 222, 133),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // icon
              Icon(
                CupertinoIcons.chat_bubble_2_fill,
                size: 150,
              ),
              SizedBox(
                height: 20,
              ),
              // Email
              Text_Field(
                  controller: EmailController,
                  text: 'Email',
                  obscureText: false),
              SizedBox(
                height: 20,
              ),
              // Password
              Text_Field(
                  controller: PassController,
                  text: 'Password',
                  obscureText: hidden,
                  suffixIcon: IconButton(
                    icon: hidden
                        ? const Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                    onPressed: () {
                      setState(() {
                        hidden = !hidden;
                      });
                    },
                  ),),
              SizedBox(
                height: 20,
              ),
              // Login Button
              GestureDetector(
                onTap: login,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black,
                  ),
                  child: Text('Login', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // If not an account, Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('New user? ',),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
