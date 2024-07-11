import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:prueba_nolatech/src/constants/constants.dart';
import 'package:prueba_nolatech/src/models/courts_model.dart';
import 'package:prueba_nolatech/src/providers/court_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Court> imagesList = [
      const Court(
          image: 'assets/images/cancha1.jpg',
          name: 'Big Court',
          type: 'Cancha A',
          price: 25),
      const Court(
          image: 'assets/images/cancha2.jpg',
          name: 'Small Court',
          type: 'Cancha B',
          price: 45),
      const Court(
          image: 'assets/images/cancha3.jpg',
          name: 'Medium Court',
          type: 'Cancha C',
          price: 30),
    ];

    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 10, bottom: 5),
                child: Text(
                  'Bienvenida Evelynn!',
                  style: GoogleFonts.caveat(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize * 1.8,
                      color: secondaryColor),
                ),
              ),
            ),
            Divider(
              color: secondaryColor.withOpacity(0.2),
              indent: 20,
              endIndent: 20,
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
              indent: 20,
              endIndent: 20,
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

  Widget cardInfoWithImage(List<Court> imagesList, context) {
    final provider = Provider.of<CourtsProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 300.0,
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, int i) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                provider.goToCourtPage(context, imagesList[i]);
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
