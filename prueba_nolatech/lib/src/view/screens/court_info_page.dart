import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:like_button/like_button.dart';
import 'package:prueba_nolatech/src/constants/constants.dart';

import '../../models/courts_model.dart';

class CourtInfo extends StatelessWidget {
  const CourtInfo({super.key, required this.courts});
  final Court courts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            carousell(context),
            courtHeaderButtons(context),
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

  Widget carousell(context) {
    return ImageSlideshow(
        indicatorRadius: 5,
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
                color: isLiked ? fontColor : Colors.grey,
              );
            },
          ),
        ),
      ),
    ]);
  }
}
