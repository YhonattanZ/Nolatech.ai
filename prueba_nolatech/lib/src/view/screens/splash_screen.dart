import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:prueba_nolatech/src/constants/constants.dart';
import 'package:prueba_nolatech/src/providers/login_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Stack(children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/front.jpg',
              fit: BoxFit.fill,
            ),
          ),
          header(),
          buttonsBar(context)
        ]));
  }

  Widget header() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tennis \nCourt',
                textAlign: TextAlign.center,
                style: GoogleFonts.caveat(
                    fontSize: fontSize * 2.5, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget buttonsBar(context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onPressed: () {
                  provider.goToLogin(context);
                },
                child: const Text(
                  'Inicia Sesion',
                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                ))),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onPressed: () {
                  provider.goToRegister(context);
                },
                child: const Text('Registrate',
                    style:
                        TextStyle(color: Colors.white, fontSize: fontSize)))),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}
