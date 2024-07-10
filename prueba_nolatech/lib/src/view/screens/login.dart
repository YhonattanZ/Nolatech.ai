import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Stack(children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ]));
  }

  Widget buttonsBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            width: double.infinity,
            child:
                ElevatedButton(onPressed: () {}, child: Text('Inicia Sesion'))),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            width: double.infinity,
            child: ElevatedButton(onPressed: () {}, child: Text('Registrate'))),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}
