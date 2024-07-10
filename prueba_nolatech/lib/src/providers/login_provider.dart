import 'package:flutter/material.dart';
import 'package:prueba_nolatech/src/view/screens/login.dart';
import 'package:prueba_nolatech/src/view/screens/register.dart';

class LoginProvider extends ChangeNotifier {
  void goToRegister(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Register()));
  }

  void goToLogin(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }
}
