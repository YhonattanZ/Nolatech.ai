import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:prueba_nolatech/src/constants/constants.dart';
import 'package:prueba_nolatech/src/models/courts_model.dart';

import 'package:prueba_nolatech/src/providers/reverse_court_provider.dart';
import 'package:prueba_nolatech/src/view/screens/reserve_court.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Court> imagesList = [
      Court(
        courtId: 1,
        image: 'assets/images/cancha1.jpg',
        name: 'Big Court',
        type: 'Cancha A',
        price: 25,
      ),
      Court(
        courtId: 2,
        image: 'assets/images/cancha2.jpg',
        name: 'Small Court',
        type: 'Cancha B',
        price: 45,
      ),
      Court(
        courtId: 3,
        image: 'assets/images/cancha3.jpg',
        name: 'Medium Court',
        type: 'Cancha C',
        price: 30,
      ),
    ];

    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 10, bottom: 5),
                child: Text(
                  'Bienvenida $userName!',
                  style: GoogleFonts.caveat(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize * 1.8,
                      color: secondaryColor),
                ),
              ),
            ),
            Divider(
              color: secondaryColor.withOpacity(0.2),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Canchas',
                    style: TextStyle(
                        fontSize: fontSize * 1.5, color: secondaryColor),
                  )),
            ),
            cardInfoWithImage(imagesList, context),
            Divider(
              color: secondaryColor.withOpacity(0.2),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Text('Reservas programadas',
                  style: TextStyle(
                      fontSize: fontSize * 1.3,
                      color: secondaryColor,
                      fontWeight: FontWeight.bold)),
            ),
            Consumer<ReserveCourtProvider>(
              builder: (_, p, i) => ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: p.bookings.length,
                  itemBuilder: (ctx, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: reservedBooking(p, i),
                      )),
            ),
          ],
        ),
      ),
    );
  }

  Widget reservedBooking(ReserveCourtProvider p, int i) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: secondaryColor.withOpacity(0.4)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: Image.asset(
                    p.bookings[i].court.image,
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  )),
            ),
            Flexible(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(p.bookings[i].court.name),
                        ],
                      ),
                      Text(p.bookings[i].court.type),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              color: secondaryColor),
                          const SizedBox(width: 10),
                          Text(DateFormat('dd/MM/yyyy')
                              .format(p.bookings[i].date)),
                        ],
                      ),
                      const Row(
                        children: [
                          Text('Reservado por:'),
                          SizedBox(width: 5),
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage(
                              'assets/images/profile.jpg',
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(userName),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.lock_clock, color: secondaryColor),
                          const SizedBox(width: 10),
                          Text('2H'),
                          SizedBox(width: 10),
                          Text('${p.bookings[i].court.price.toInt()}\$')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget cardInfoWithImage(List<Court> imagesList, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 380.0,
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, int i) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ReserveCourt(courts: imagesList[i])));
                print(imagesList[i].name);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: secondaryColor),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.asset(
                          imagesList[i].image,
                          fit: BoxFit.cover,
                          height: 150,
                          width: 250,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        imagesList[i].name,
                        style: const TextStyle(
                            fontSize: fontSize * 1.2,
                            color: secondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        imagesList[i].type,
                        style: const TextStyle(
                          fontSize: fontSize,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined,
                              color: secondaryColor),
                          const SizedBox(width: 5),
                          // Text(
                          //   DateFormat('dd/MM/yyyy')
                          //       .format(imagesList[i].startDate!),
                          //   style: const TextStyle(
                          //       color: secondaryColor, fontSize: fontSize),
                          // )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text('Disponible',
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: fontSize - 2)),
                          SizedBox(width: 10),
                          Icon(
                            Icons.circle,
                            size: 15,
                            color: fontColor,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: fontColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReserveCourt(courts: imagesList[i])));
                            },
                            child: const Text(
                              'Reservar',
                              style: TextStyle(
                                  color: Colors.white, fontSize: fontSize),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
        actions: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 22,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/profile.jpg',
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.white,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30,
                  ))
            ],
          )
        ],
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text('Tennis Court',
              style: GoogleFonts.caveat(
                  fontSize: fontSize * 1.5, color: Colors.white)),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[primaryColor, fontColor]),
          ),
        ));
  }
}
