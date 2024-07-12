import 'package:prueba_nolatech/src/models/courts_model.dart';

class Booking {
  final String courtId;
  final String instructor;
  final DateTime date;
  final String userName;
  final DateTime startTime;
  final DateTime endTime;
  final Court court;

  Booking(
      {required this.startTime,
      required this.endTime,
      required this.instructor,
      required this.courtId,
      required this.date,
      required this.userName,
      required this.court});
}
