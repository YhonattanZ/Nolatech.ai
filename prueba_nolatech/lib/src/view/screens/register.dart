import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:prueba_nolatech/src/constants/constants.dart';

import 'package:prueba_nolatech/src/providers/register_provider.dart';
import 'package:prueba_nolatech/src/view/widgets/password_textfield.dart';
import 'package:prueba_nolatech/src/view/widgets/textfield.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              Positioned(top: -200, left: -60, child: topShape(size.width)),
              Positioned(
                  bottom: -200, left: -40, child: bottomShape(size.width)),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(children: [
                  customAppBar(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Center(child: textfields(context)),
                  ),
                  const Spacer(),
                  footer(context)
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget footer(context) {
    final provider = Provider.of<RegisterProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          onPressed: () {
            provider.goToMainPage(context);
          },
          child: Text('Registrarme',
              style: GoogleFonts.caveat(
                  fontSize: fontSize * 1.5, color: Colors.white))),
    );
  }

  Widget customAppBar(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: 40,
                  width: 40,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text('Crea tu cuenta',
              textAlign: TextAlign.center,
              style: GoogleFonts.caveat(
                  fontSize: fontSize * 2, color: Colors.white)),
        ),
      ],
    );
  }

  Widget textfields(context) {
    return Column(
      children: [
        Consumer<RegisterProvider>(
            builder: (_, p, child) => CustomTextfield(
                hint: 'Nombre y Apellido',
                label: 'Ingrese su informacion',
                icon: Icons.person_2_outlined,
                controller: p.nameCtrl)),
        Consumer<RegisterProvider>(
            builder: (_, p, child) => CustomTextfield(
                hint: 'Email',
                label: 'Ingrese su email',
                icon: Icons.email_outlined,
                controller: p.emailCtrl)),
        Consumer<RegisterProvider>(
            builder: (_, p, child) => CustomTextfield(
                hint: 'Telefono',
                label: 'Ingrese su numero de contacto',
                icon: Icons.phone_outlined,
                controller: p.phoneCtrl)),
        Consumer<RegisterProvider>(
            builder: (_, p, child) => CustomPasswordTextfield(
                hint: 'Contraseña',
                label: 'Ingrese su contraseña',
                controller: p.passwordCtrl,
                obsText: p.showPassword,
                onPressed: () {
                  p.isShowPassword(!p.showPassword);
                })),
        Consumer<RegisterProvider>(
            builder: (_, p, child) => CustomPasswordTextfield(
                hint: 'Confirmar ontraseña',
                label: 'Repita su contraseña',
                controller: p.rePasswordCtrl,
                obsText: p.showConfirmPassword,
                onPressed: () {
                  p.isConfirmShowPassword(!p.showConfirmPassword);
                })),
      ],
    );
  }
}
