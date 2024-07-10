import 'package:flutter/material.dart';
import 'dart:math' as math;

const Color primaryColor = Color(0xff44A1F2);
const Color secondaryColor = Color(0xff0E0359);
const Color fontColor = Color(0xffA8D95F);
const double fontSize = 18;

Widget topShape(double width) {
  return Transform.rotate(
    angle: -35 * math.pi / 180,
    child: Container(
      width: 1.2 * width,
      height: 1.2 * width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: LinearGradient(
              begin: const Alignment(-0.2, -0.8),
              end: Alignment.bottomCenter,
              colors: [fontColor, primaryColor.withOpacity(0.7)])),
    ),
  );
}

Widget bottomShape(double width) {
  return Container(
    width: 1.5 * width,
    height: 1.5 * width,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
            begin: const Alignment(0.6, -1.1),
            end: const Alignment(0.7, 0.8),
            colors: [
              fontColor.withOpacity(0.3),
              primaryColor.withOpacity(0.9)
            ])),
  );
}
