import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:prueba_nolatech/src/view/screens/my_reserves.dart';

import 'package:timezone/timezone.dart' as tz;
import '../models/courts_model.dart';

//TODO: AGREGAR CLIMA, AGREGAR CALCULADORA DE HORA DE PRECIOS
class ReserveCourtProvider extends ChangeNotifier {
  List<Court> reservedCourts = [];
  String? idCalendar;

  void addCourt(Court court) {
    if (reservedCourts.length < 3) {
      reservedCourts.add(court);
    } else {
      print("No se puede reservar más de 3 canchas.");
    }
  }

  void deleteCourt(Court court) {
    reservedCourts.remove(court);
  }

  void goToMyReserves(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MyReserves()));
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
