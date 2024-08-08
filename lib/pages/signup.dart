// ignore_for_file: prefer_const_constructors

import 'package:chatapp/components/textfield.dart';
import 'package:chatapp/utilities/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final void Function()? onTap;
  const SignUp({super.key, required this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
   bool hidden = true;
   bool hidden2 = true;
  TextEditingController EmailController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController PassController = TextEditingController();
  TextEditingController ConfirmPassController = TextEditingController();
  TextEditingController NumberController = TextEditingController();

  void SignUp() async {
    if (PassController.text != ConfirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }

    final authService = Provider.of<Auth>(context, listen: false);

    try {
      await authService.signUpWithEmailAndPassword(EmailController.text,
          PassController.text, NameController.text, NumberController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 222, 133),
      body: SafeArea(
          child: SingleChildScrollView(
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
                // Name
                Text_Field(
                    controller: NameController,
                    text: 'Name',
                    obscureText: false),
                SizedBox(
                  height: 20,
                ),
                // Number
                IntlPhoneField(
                  decoration: InputDecoration(
                    hintText: 'Mobile Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    NumberController.text = phone.completeNumber;
                    print(phone.completeNumber);
                  },
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
                  ),
                    ),
                SizedBox(
                  height: 20,
                ),
                // Confirm Password
                Text_Field(
                    controller: ConfirmPassController,
                    text: 'Confirm Password',
                    obscureText: hidden2,
                    suffixIcon: IconButton(
                    icon: hidden2
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
                        hidden2 = !hidden2;
                      });
                    },
                  ),),
                SizedBox(
                  height: 20,
                ),
                // Sign up Button
                GestureDetector(
                  onTap: SignUp,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.black,
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Already have an account, Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already a user? '),
                    GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Login',
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
        ),
      )),
    );
  }
}
