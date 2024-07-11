import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:prueba_nolatech/src/constants/constants.dart';

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
                    onPressed: () {},
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
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 15,
              itemBuilder: (ctx, i) => Container(),
            ),
          ],
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
