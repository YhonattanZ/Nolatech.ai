import 'package:flutter/material.dart';
import 'package:prueba_nolatech/src/view/screens/login.dart';
import 'package:prueba_nolatech/src/view/screens/register.dart';

class LoginProvider extends ChangeNotifier {
  bool showPassword = false;
  bool isChecked = false;

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  void goToRegister(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Register()));
  }

  void goToLogin(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  void isShowPassword(bool password) {
    showPassword = password;
    print(showPassword);
    notifyListeners();
  }

  void isCheckboxActive(bool checked) {
    isChecked = checked;
    print(isChecked);
    notifyListeners();
  }
}
