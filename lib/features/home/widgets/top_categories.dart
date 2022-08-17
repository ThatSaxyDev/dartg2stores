import 'package:dart_g2_stores/features/home/screens/category_deals_screen.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.builder(
        shrinkWrap: true,
        itemExtent: 75.w,
        scrollDirection: Axis.horizontal,
        itemCount: AppIcons.categoryIcons.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(
                context, AppIcons.categoryIcons[index]['title']!),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: Image.asset(
                      AppIcons.categoryIcons[index]['image']!,
                      fit: BoxFit.cover,
                      height: 40.h,
                      width: 40.w,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  AppIcons.categoryIcons[index]['title']!,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
