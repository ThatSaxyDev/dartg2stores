import 'package:carousel_slider/carousel_slider.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: AppImages.carouselImages.map(
        (i) {
          return Builder(
            builder: (BuildContext context) => Image.asset(
              i,
              fit: BoxFit.cover,
              height: 200.h,
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        autoPlay: true,
        viewportFraction: 1,
        height: 200.h,
      ),
    );
  }
}
