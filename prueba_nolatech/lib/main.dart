import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/view/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: const [],
      child: MaterialApp(
        localizationsDelegates: const [],
        supportedLocales: const [
          Locale('es'),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Prueba Nolatech',
        theme: ThemeData(primarySwatch: Colors.blue),
        //The main page will be Login
        home: const Login(),
      ),
    );
  }
}
