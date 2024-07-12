import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:prueba_nolatech/src/constants/constants.dart';
import 'package:prueba_nolatech/src/providers/reverse_court_provider.dart';
import 'package:prueba_nolatech/src/view/screens/main_page.dart';

class MyReserves extends StatelessWidget {
  const MyReserves({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: secondaryColor,
                        ),
                        Text('Programar reserva ',
                            style: TextStyle(
                                fontSize: fontSize, color: secondaryColor))
                      ],
                    )),
              ),
            ),
            cardListview(),
          ],
        ),
      ),
    );
  }

  Widget cardListview() {
    return Consumer<ReserveCourtProvider>(
      builder: (_, p, i) => ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: p.bookings.length,
        itemBuilder: (ctx, i) => cardInfo(p, i),
      ),
    );
  }

  Widget cardInfo(ReserveCourtProvider p, int i) {
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
                      Row(
                        children: [
                          const Text('Reservado por:'),
                          const SizedBox(width: 5),
                          const CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage(
                              'assets/images/profile.jpg',
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(p.bookings[i].userName),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.lock_clock, color: secondaryColor),
                          const SizedBox(width: 10),
                          Text(p.bookings[i].startTime
                              .difference(p.bookings[i].endTime)
                              .toString()),
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
