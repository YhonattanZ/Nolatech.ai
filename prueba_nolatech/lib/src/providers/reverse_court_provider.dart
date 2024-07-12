import 'dart:convert';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prueba_nolatech/src/view/screens/confirm_reserve_court.dart';
import 'package:prueba_nolatech/src/view/screens/my_reserves.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timezone/timezone.dart' as tz;
import '../models/booking.dart';

//TODO: AGREGAR CLIMA
class ReserveCourtProvider extends ChangeNotifier {
  Booking? booking;
  List<Booking> bookings = [];

  String? instructorName;
  String? idCalendar;
  DateTime date = DateTime.now();
  DateTime? initHour;
  DateTime? endHour;

  bool isDateAvailable = true;

  TextEditingController commentsCtrl = TextEditingController();

  String formatDuration(DateTime startTime, DateTime endTime) {
    Duration duration = endTime.difference(startTime);
    int totalHours = duration.inHours;

    String formattedDuration = totalHours.toString().padLeft(1, '0');
    return "${formattedDuration}H";
  }

//VERIFY IF THE COURT IS AVAILABLE
  bool isCourtAvailable(DateTime desiredDate, DateTime startTime,
      DateTime endTime, String courtId) {
    for (Booking booking in bookings) {
      if (booking.courtId == courtId && booking.date == desiredDate) {
        if ((startTime.isAfter(booking.startTime) &&
                startTime.isBefore(booking.endTime)) ||
            (endTime.isAfter(booking.startTime) &&
                endTime.isBefore(booking.endTime)) ||
            (startTime.isAtSameMomentAs(booking.startTime) ||
                endTime.isAtSameMomentAs(booking.endTime))) {
          return false;
        }
      }
    }

    return true;
  }

//SHARED PREFERENCES
  void saveBooking(Booking b) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String key = 'reservedBooking${b.date}';
    List<Booking> bookingToday = await loadBooking(b.date.toString());

    if (bookingToday.length < 3) {
      bookingToday.add(b);

      String bookingJson =
          jsonEncode(bookingToday.map((b) => b.toJson()).toList());

      await prefs.setString(key, bookingJson);
    } else {
      print(
          'No se puede reservar más de 3 canchas para la fecha seleccionada.');
    }
  }

//De ser necesario, esta la opcion para cargar los agendamientos ya que en los requisitos no se solicita esa funcionalidad
  Future<List<Booking>> loadBooking(String bookingDate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = 'reservedBooking$bookingDate';

    String? bookingJson = prefs.getString(key);
    if (bookingJson != null) {
      List<dynamic> bookingList = jsonDecode(bookingJson);
      return bookingList.map((bk) => Booking.fromJson(bk)).toList();
    } else {
      return [];
    }
  }

  double calculateTotalCost(
      DateTime startTime, DateTime endTime, double pricePerHour) {
    Duration duration = endTime.difference(startTime);
    int totalHours = duration.inHours;
    return totalHours * pricePerHour;
  }

  void showConfirmationDialog(
      BuildContext context, String title, String message, Booking booking) {
    // Muestra el AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            // Botón "No"
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            // Botón "Sí"
            TextButton(
              child: Text('Sí'),
              onPressed: () {
                deleteCourt(booking);
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  void deleteCourt(Booking booking) {
    bookings.remove(booking);
  }

  void goToConfirmReserve(context, Booking booking) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConfirmReserveCourt(
                  booking: booking,
                )));
  }

  void goToMyReserves(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MyReserves()));
  }

  bool addBooking(Booking booking) {
    if (_checkAvailability(booking.courtId, booking.date)) {
      if (bookings.length < 3) {
        bookings.add(booking);
        print(booking);
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  bool _checkAvailability(String courtId, DateTime date) {
    int count =
        bookings.where((b) => b.courtId == courtId && b.date == date).length;
    return count < 3;
  }

  void selectDate(BuildContext context, String courtId) {
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
                          isDateAvailable = isCourtAvailable(
                              value, initHour!, endHour!, courtId);
                          date = value;
                          notifyListeners();
                        },
                      ))
                ],
              ));
        });
  }

  void selectInitHour(BuildContext context) {
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

  void selectEndHour(BuildContext context) {
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

  DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();

  Future<void> retrieveCalendars() async {
    var permissionsGranted = await deviceCalendarPlugin.hasPermissions();
    if (permissionsGranted.isSuccess && !permissionsGranted.data!) {
      permissionsGranted = await deviceCalendarPlugin.requestPermissions();
      if (!permissionsGranted.isSuccess || !permissionsGranted.data!) {
        print("Permisos de calendario denegados");
        return;
      }
    }

    final calendarsResult = await deviceCalendarPlugin.retrieveCalendars();
    if (calendarsResult.isSuccess && calendarsResult.data != null) {
      for (var calendar in calendarsResult.data!) {
        idCalendar = calendarsResult.data!.first.id;
        notifyListeners();
        print("Calendario encontrado: ${calendar.name}, ID: ${calendar.id}");
      }
    } else {
      print("Error al recuperar calendarios: ${calendarsResult.errors}");
    }
  }

  Future<void> addEventIfSlotAvailable(DateTime startTime, DateTime endTime,
      String calendarId, String title, String description) async {
    // Solicitar permisos para acceder al calendario
    var permissionsGranted = await deviceCalendarPlugin.hasPermissions();
    if (permissionsGranted.isSuccess && !permissionsGranted.data!) {
      permissionsGranted = await deviceCalendarPlugin.requestPermissions();
      if (!permissionsGranted.isSuccess || !permissionsGranted.data!) {
        print("Permisos de calendario denegados");
        return;
      }
    }

    // Consultar eventos existentes para la fecha dada
    final startDate = DateTime(startTime.year, startTime.month, startTime.day);
    final endDate =
        DateTime(endTime.year, endTime.month, endTime.day, 23, 59, 59);
    final eventsResult = await deviceCalendarPlugin.retrieveEvents(
      calendarId,
      RetrieveEventsParams(
        startDate: startDate,
        endDate: endDate,
      ),
    );

    if (eventsResult.isSuccess && eventsResult.data != null) {
      final events = eventsResult.data!;
      if (events.length < 3) {
        // Hay menos de 3 eventos, se puede agregar uno nuevo
        final Event newEvent = Event(
          title: title,
          description: description,
          calendarId,
          start: TZDateTime.from(startDate, tz.local),
          end: TZDateTime.from(endDate, tz.local),
        );
        final createEventResult =
            await deviceCalendarPlugin.createOrUpdateEvent(newEvent);
        if (createEventResult!.isSuccess && createEventResult.data != null) {
          print("Evento agregado con éxito: ${createEventResult.data}");
        } else {
          print("Error al agregar el evento: ${createEventResult.errors}");
        }
      } else {
        // Ya hay 3 eventos para ese día
        print("No se puede agregar el evento. Ya hay 3 eventos para ese día.");
      }
    } else {
      print("Error al recuperar eventos: ${eventsResult.errors}");
    }
  }
}
