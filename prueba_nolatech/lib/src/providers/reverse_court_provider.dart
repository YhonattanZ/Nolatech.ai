import 'package:flutter/material.dart';

import '../models/courts_model.dart';

class ReverseCourtProvider extends ChangeNotifier {
  List<Court> reservedCourts = [];

  void addCourt(Court court) {
    reservedCourts.add(court);
  }

  void modifyCourt(Court court) {}

  void deleteCourt(Court court) {
    reservedCourts.remove(court);
  }
}
