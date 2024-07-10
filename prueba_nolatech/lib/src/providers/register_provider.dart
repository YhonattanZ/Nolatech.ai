import 'package:flutter/material.dart';
import 'package:prueba_nolatech/src/view/screens/main_page.dart';

class RegisterProvider extends ChangeNotifier {
  bool showPassword = false;
  bool showConfirmPassword = false;

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController rePasswordCtrl = TextEditingController();

  void isShowPassword(bool password) {
    showPassword = password;
    print(showPassword);
    notifyListeners();
  }

  void isConfirmShowPassword(bool password) {
    showConfirmPassword = password;
    print(showPassword);
    notifyListeners();
  }

  void goToMainPage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainPage()));
  }
}
