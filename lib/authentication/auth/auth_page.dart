import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/login_or_register.dart';
import '../../pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // user is Logged In
        if (snapshot.hasData) {
          return const HomePage();
        }
        // user is Not Logged In
        else {
          return const LoginOrRegisterPage();
        }
      },
    );
  }
}
