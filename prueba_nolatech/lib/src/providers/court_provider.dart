import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prueba_nolatech/src/models/courts_model.dart';
import 'package:prueba_nolatech/src/view/screens/reserve_court.dart';
import 'package:prueba_nolatech/src/view/screens/confirm_reserve_court.dart';

class CourtsProvider extends ChangeNotifier {
  void goToCourtPage(context, Court court) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ReserveCourt(courts: court)));
  }

  // void goToReservePage(context, Court court) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => ConfirmReserveCourt(courts: court)));
  // }
}
