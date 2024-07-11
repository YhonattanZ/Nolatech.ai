import 'package:flutter/material.dart';
import 'package:prueba_nolatech/src/models/courts_model.dart';
import 'package:prueba_nolatech/src/view/screens/court_info_page.dart';

class CourtsProvider extends ChangeNotifier {
  String? selectedInstructor;

  void selectInstructor(String instructor) {
    selectedInstructor = instructor;
    print(selectedInstructor);
    notifyListeners();
  }

  void goToCourtPage(context, Court court) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CourtInfo(courts: court)));
  }
}
