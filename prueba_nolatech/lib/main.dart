import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_nolatech/src/providers/register_provider.dart';

import 'src/providers/login_provider.dart';
import 'src/view/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prueba Nolatech',
        theme: ThemeData(primarySwatch: Colors.blue),
        //The main page will be Login
        home: const SplashScreen(),
      ),
    );
  }
}
