import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_nolatech/src/constants/constants.dart';
import 'package:prueba_nolatech/src/providers/login_provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          customAppBar(context),
          textfields(context),
          checkbox(),
          TextButton(
              onPressed: () {},
              child: Text('¿Olvidaste tu contraseña?',
                  style: TextStyle(color: secondaryColor))),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: () {},
                child: Text('Inicia sesion',
                    style: TextStyle(color: Colors.white, fontSize: fontSize))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¿Aun no tienes una cuenta?'),
              TextButton(
                  onPressed: () {},
                  child: Text(
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
    return Align(
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
                  color: primaryColor,
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
    );
  }

  Widget textfields(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextFormField(
            decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade400)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: fontColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: secondaryColor)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.only(left: 5, top: 12),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: 'Email',
                labelText: 'Ingrese su email',
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: secondaryColor,
                )),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: Consumer<LoginProvider>(
              builder: (_, p, child) => TextFormField(
                obscureText: p.showPassword,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: secondaryColor)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 5, top: 12),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'Contraseña',
                  labelText: 'Ingrese su contraseña',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: secondaryColor,
                  ),
                  suffixIcon: IconButton(
                    icon: p.showPassword
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Color.fromRGBO(158, 158, 158, 1),
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                    onPressed: () {
                      p.isShowPassword(!p.showPassword);
                    },
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
