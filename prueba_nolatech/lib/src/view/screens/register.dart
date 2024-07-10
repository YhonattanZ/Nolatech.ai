import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:prueba_nolatech/src/constants/constants.dart';
import 'package:prueba_nolatech/src/providers/login_provider.dart';
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
                  const SizedBox(height: 200),
                  textfields(context),
                  checkbox(),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        children: [
          TextButton(
              onPressed: () {},
              child: const Text('¿Olvidaste tu contraseña?',
                  style: TextStyle(color: secondaryColor))),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: () {},
                child: const Text('Inicia sesion',
                    style: TextStyle(color: Colors.white, fontSize: fontSize))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Aun no tienes una cuenta?'),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()));
                  },
                  child: const Text(
                    'Registrate',
                    style: TextStyle(color: secondaryColor),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget checkbox() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Row(
        children: [
          Consumer<LoginProvider>(
              builder: (_, p, child) => Checkbox.adaptive(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  activeColor: secondaryColor,
                  value: p.isChecked,
                  onChanged: (value) {
                    p.isCheckboxActive(value!);
                  })),
          const Text(
            'Recordar Contraseña',
            style: TextStyle(color: secondaryColor),
          )
        ],
      ),
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
          child: Text('Registrate',
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
                hint: 'Email',
                label: 'Ingrese su email',
                icon: Icons.email_outlined,
                controller: p.emailCtrl)),
        const SizedBox(height: 20),
        Consumer<RegisterProvider>(
            builder: (_, p, child) => CustomPasswordTextfield(
                hint: 'Contraseña',
                label: 'Ingrese su contraseña',
                controller: p.passwordCtrl,
                obsText: p.showPassword,
                onPressed: () {
                  p.isShowPassword(!p.showPassword);
                })),
      ],
    );
  }
}
