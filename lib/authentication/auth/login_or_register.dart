import 'package:flutter/material.dart';

import '../screens/loging_page.dart';
import '../screens/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;

  void tooglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage
        ? LogingPage(
            onTap: tooglePages,
          )
        : RegisterPage(
            onTap: tooglePages,
          );
  }
}
