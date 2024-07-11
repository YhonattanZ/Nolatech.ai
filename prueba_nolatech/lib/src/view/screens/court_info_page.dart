import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:prueba_nolatech/src/constants/constants.dart';
import 'package:prueba_nolatech/src/providers/court_provider.dart';
import 'package:prueba_nolatech/src/view/widgets/custom_dropdown.dart';

import '../../models/courts_model.dart';

class CourtInfo extends StatelessWidget {
  const CourtInfo({super.key, required this.courts});
  final Court courts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                carousell(context),
                courtHeaderButtons(context),
              ],
            ),
            infoCourt()
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_outline,
                color: secondaryColor,
                size: 30,
              )),
        )
      ],
    );
  }

  Widget infoCourt() {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  courts.name,
                  style: const TextStyle(
                      color: secondaryColor,
                      fontSize: fontSize * 1.5,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${courts.price.toInt()}\$',
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: fontSize * 1.5,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              courts.type,
              style: const TextStyle(
                color: secondaryColor,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Disponible',
                  style: TextStyle(
                      color: secondaryColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '4 a 6PM',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            instructor()
          ],
        ),
      ),
    );
  }

  Widget instructor() {
    List<String> instructors = [
      'Antonio Bastidas',
      'Felipe Fernandez',
      'Rosa Maria'
    ];

    return Consumer<CourtsProvider>(
        builder: (_, p, i) => CustomDropdown(
              dropdownValue: p.selectedInstructor,
              permanentHint: 'Instructor',
              shadow: const BoxShadow(color: Colors.transparent),
              border: Border.all(color: secondaryColor),
              items: instructors
                  .map((e) => DropdownMenuItem<String>(
                      alignment: Alignment.centerRight,
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          e,
                          maxLines: 2,
                        ),
                      )))
                  .toList(),
              onChanged: (p0) {
                p.selectedInstructor = p0;
              },
            ));
  }

  Widget carousell(context) {
    return ImageSlideshow(
        indicatorRadius: 6,
        width: double.infinity,
        height: 250,
        initialPage: 0,
        indicatorColor: secondaryColor,
        indicatorBackgroundColor: Colors.grey,
        children: [
          ...List<Widget>.generate(
              3,
              (i) => Image.asset(
                    courts.image,
                    fit: BoxFit.cover,
                  ))
        ]);
  }

  Widget courtHeaderButtons(context) {
    return Stack(children: [
      Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              margin: const EdgeInsets.only(left: 20, top: 30),
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: const Icon(Icons.arrow_back, color: secondaryColor)),
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: const EdgeInsets.only(right: 20, top: 20),
          width: 50,
          height: 50,
          child: LikeButton(
            circleColor:
                const CircleColor(start: Colors.grey, end: secondaryColor),
            bubblesColor: const BubblesColor(
                dotPrimaryColor: primaryColor, dotSecondaryColor: fontColor),
            crossAxisAlignment: CrossAxisAlignment.center,
            size: 40,
            likeBuilder: (isLiked) {
              if (!isLiked) {
                return const Icon(
                  Icons.favorite_border,
                  size: 40,
                  color: secondaryColor,
                );
              }
              return Icon(
                Icons.favorite,
                size: 40,
                color: isLiked ? secondaryColor : Colors.grey,
              );
            },
          ),
        ),
      ),
    ]);
  }
}
