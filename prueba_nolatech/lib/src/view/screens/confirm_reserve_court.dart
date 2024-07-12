import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:prueba_nolatech/src/constants/constants.dart';
import 'package:prueba_nolatech/src/models/booking.dart';
import 'package:prueba_nolatech/src/providers/court_provider.dart';

import '../../models/courts_model.dart';
import '../../providers/reverse_court_provider.dart';

class ConfirmReserveCourt extends StatelessWidget {
  const ConfirmReserveCourt({super.key, required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                carousell(context),
                courtHeaderButtons(context),
              ],
            ),
            infoCourt(context),
            resumeInfoCourt(context),
            const SizedBox(height: 20),
            footer(context),
          ],
        ),
      ),
    );
  }

  Widget footer(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total a pagar:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize * 1.2,
                      color: secondaryColor),
                ),
                Text('${booking.court.price}\$',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize * 1.2,
                        color: secondaryColor)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
            child: SizedBox(
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: secondaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: secondaryColor,
                      ),
                      Text('Reprogramar',
                          style: TextStyle(
                              fontSize: fontSize, color: secondaryColor))
                    ],
                  )),
            ),
          ),
          Consumer<ReserveCourtProvider>(
            builder: (_, p, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: fontColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {
                      // p
                      //     .addEventIfSlotAvailable(
                      //         provider.date,
                      //         provider.date,
                      //         p.idCalendar.toString(),
                      //         '${courts.name} ${courts.type}',
                      //         provider.commentsCtrl.text)
                      //     .then((e) {
                      // p.addCourt(courts);
                      // p.goToMyReserves(context);
                      // });
                    },
                    child: const Text('Pagar',
                        style: TextStyle(
                            fontSize: fontSize * 1.2, color: Colors.white))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: secondaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar',
                      style: TextStyle(
                          fontSize: fontSize * 1.2, color: secondaryColor))),
            ),
          )
        ],
      ),
    );
  }

  Widget resumeInfoCourt(context) {
    final p = Provider.of<ReserveCourtProvider>(context, listen: false);

    return SizedBox(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'RESUMEN',
            style: TextStyle(
                fontSize: fontSize * 1.2,
                color: secondaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoRow(
                  booking.court.type.toString(), Icons.sports_tennis_outlined),
              infoRow(DateFormat('dd/MM/yyyy').format(booking.date),
                  Icons.calendar_month),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoRow(p.instructorName!, Icons.person_outline_outlined),
              infoRow(
                  '${DateFormat('hh:mm').format(p.initHour!)} - ${DateFormat('hh:mm').format(p.endHour!)}',
                  Icons.lock_clock_outlined),
            ],
          ),
        ),
      ],
    ));
  }

  Widget infoRow(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: secondaryColor),
        Text(
          title,
          style: const TextStyle(fontSize: fontSize - 2),
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_outline,
                color: secondaryColor,
                size: 30,
              )),
        )
      ],
    );
  }

  Widget infoCourt(context) {
    final p = Provider.of<ReserveCourtProvider>(context, listen: false);

    return Container(
      width: double.infinity,
      height: 150,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking.court.name,
                  style: const TextStyle(
                      color: secondaryColor,
                      fontSize: fontSize * 1.5,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${booking.court.price.toInt()}\$',
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: fontSize * 1.5,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Text(
                booking.court.type,
                style: const TextStyle(
                    color: secondaryColor, fontSize: fontSize - 2),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Disponible',
                  style: TextStyle(
                      color: secondaryColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '4 a 6PM',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget carousell(context) {
    final p = Provider.of<ReserveCourtProvider>(context, listen: false);

    return ImageSlideshow(
        indicatorRadius: 6,
        width: double.infinity,
        height: 250,
        initialPage: 0,
        indicatorColor: secondaryColor,
        indicatorBackgroundColor: Colors.grey,
        children: [
          ...List<Widget>.generate(
              3,
              (i) => Image.asset(
                    booking.court.image,
                    fit: BoxFit.cover,
                  ))
        ]);
  }

  Widget courtHeaderButtons(context) {
    return Stack(children: [
      Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              margin: const EdgeInsets.only(left: 20, top: 30),
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: const Icon(Icons.arrow_back, color: secondaryColor)),
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: const EdgeInsets.only(right: 20, top: 20),
          width: 50,
          height: 50,
          child: LikeButton(
            circleColor:
                const CircleColor(start: Colors.grey, end: secondaryColor),
            bubblesColor: const BubblesColor(
                dotPrimaryColor: primaryColor, dotSecondaryColor: fontColor),
            crossAxisAlignment: CrossAxisAlignment.center,
            size: 40,
            likeBuilder: (isLiked) {
              if (!isLiked) {
                return const Icon(
                  Icons.favorite_border,
                  size: 40,
                  color: secondaryColor,
                );
              }
              return Icon(
                Icons.favorite,
                size: 40,
                color: isLiked ? secondaryColor : Colors.grey,
              );
            },
          ),
        ),
      ),
    ]);
  }
}
