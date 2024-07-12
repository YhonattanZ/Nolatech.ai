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

  Map<String, dynamic> toJson() => {
        'court_id': courtId,
        'instructor': instructor,
        'date': date,
        'name': userName,
        'start_date': startTime,
        'end_date': endTime,
        'court': court
      };

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
        courtId: json['court_id'],
        instructor: json['instructor'],
        date: json['date'],
        userName: json['name'],
        startTime: json['start_date'],
        endTime: json['end_date'],
        court: json['court']);
  }
}
