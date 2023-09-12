import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/text_field.dart';

class LogingPage extends StatefulWidget {
  final Function() onTap;

  const LogingPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LogingPage> createState() => _LogingPageState();
}

class _LogingPageState extends State<LogingPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  void showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  void signIn() async {
    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      showAlertDialog(e.code);
      print(e.code);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // icon
                        const Icon(
                          Icons.lock,
                          size: 100,
                        ),

                        // welcome message
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'Welcome back, you\'ve been missed',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),

                        // email textfield
                        const SizedBox(
                          height: 50,
                        ),
                        MyTextfield(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                        ),

                        // password textfield
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextfield(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),

                        // signin button
                        const SizedBox(
                          height: 10,
                        ),
                        MyButton(
                          text: 'Sign In',
                          onTap: signIn,
                        ),

                        // go to register page
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not a member?',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                'Register Now',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
