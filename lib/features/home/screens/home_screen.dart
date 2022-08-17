import 'package:dart_g2_stores/features/home/widgets/address_box.dart';
import 'package:dart_g2_stores/features/home/widgets/carousel_image.dart';
import 'package:dart_g2_stores/features/home/widgets/deal_of_the_day.dart';
import 'package:dart_g2_stores/features/home/widgets/keep_shopping.dart';
import 'package:dart_g2_stores/features/home/widgets/top_categories.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:dart_g2_stores/shared/widgets/search_bar.dart';
import 'package:dart_g2_stores/shared/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.blue02,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          title: const SearchBar(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Column(
          children: [
            const AddressBox(),
            Spc(h: 10.h),
            const TopCategories(),
            Spc(h: 10.h),
            const CarouselImage(),
            Spc(h: 15.h),
            const DealOfTheDay(),
            Spc(h: 20.h),
            Text(
              'Dart G2 Stores',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryBlue,
              ),
            ),
            Spc(h: 15.h),
            const KeepShopping(),
          ],
        ),
      ),
    );
  }
}
