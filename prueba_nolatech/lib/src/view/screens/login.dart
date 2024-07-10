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
        children: [customAppBar(context), textfields(context)],
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
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextFormField(
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.only(left: 5, top: 12),
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
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: EdgeInsets.only(left: 5, top: 12),
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
