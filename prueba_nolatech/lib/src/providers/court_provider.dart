import 'package:flutter/material.dart';
import 'package:prueba_nolatech/src/models/courts_model.dart';
import 'package:prueba_nolatech/src/view/screens/court_info_page.dart';

class CourtsProvider extends ChangeNotifier {
  void goToCourtPage(context, Court court) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CourtInfo(courts: court)));
  }
}
