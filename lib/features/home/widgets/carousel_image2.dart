import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';

class CarouselImage2 extends StatelessWidget {
  const CarouselImage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariable.carouselImages2.map(
        (i) {
          return Builder(
            builder: (BuildContext context) => Image.asset(
              i,
              fit: BoxFit.fitWidth,
              height: 250,
              width: 450,
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 250,
      ),
    );
  }
}
