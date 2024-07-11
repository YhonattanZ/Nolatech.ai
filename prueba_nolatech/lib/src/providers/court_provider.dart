import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prueba_nolatech/src/models/courts_model.dart';
import 'package:prueba_nolatech/src/view/screens/court_info_page.dart';

class CourtsProvider extends ChangeNotifier {
  String? selectedInstructor;
  DateTime date = DateTime.now();
  DateTime? initHour;
  DateTime? endHour;

  TextEditingController commentsCtrl = TextEditingController();

  void selectInstructor(String instructor) {
    selectedInstructor = instructor;
    print(selectedInstructor);
    notifyListeners();
  }

  void goToCourtPage(context, Court court) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CourtInfo(courts: court)));
  }

  void showDate(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
              height: 200,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                      height: 190,
                      child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (value) {
                          date = value;
                          notifyListeners();
                        },
                      ))
                ],
              ));
        });
  }

  void showInitHour(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
              height: 200,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                      height: 190,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (value) {
                          initHour = value;
                          notifyListeners();
                        },
                      ))
                ],
              ));
        });
  }

  void showEndHour(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
              height: 200,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                      height: 190,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (value) {
                          endHour = value;
                          notifyListeners();
                        },
                      ))
                ],
              ));
        });
  }
}
