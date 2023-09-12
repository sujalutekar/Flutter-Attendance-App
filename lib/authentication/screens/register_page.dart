import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function() onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  bool isLoading = false;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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

  void signUp() async {
    try {
      setState(() {
        isLoading = true;
      });

      if (passwordController.text != confirmPasswordController.text) {
        showAlertDialog('Password do not match');
      } else {
        var userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (userCredential.user != null) {
          _firebaseFirestore
              .collection('users')
              .doc(userCredential.user?.uid)
              .set({
            'name': nameController.text,
            'email': emailController.text,
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      showAlertDialog(e.code);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
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
                          'Let\'s Create a account for you',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),

                        const SizedBox(
                          height: 50,
                        ),

                        // Name textfield
                        MyTextfield(
                          controller: nameController,
                          hintText: 'Name',
                          obscureText: false,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // email textfield
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

                        // Confirm Password
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextfield(
                          controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText: true,
                        ),

                        // signin button
                        const SizedBox(
                          height: 10,
                        ),
                        MyButton(
                          text: 'Sign Up',
                          onTap: signUp,
                        ),

                        // go to register page
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already a member?',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                'Login now',
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
