import 'package:dart_g2_stores/models/product.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_texts.dart';
import 'package:dart_g2_stores/shared/widgets/stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    double averageRating = 0;
    if (totalRating != 0) {
      averageRating = totalRating / product.rating!.length;
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: [
          Image.network(
            product.images[0],
            fit: BoxFit.fitWidth,
            height: 135.h,
            width: 135.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // width: 235.w,
                  padding: EdgeInsets.only(
                    left: 10.w,
                    top: 5.h,
                  ),
                  child: Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  // width: 235.w,
                  padding: EdgeInsets.only(
                    left: 10.w,
                    top: 5.h,
                  ),
                  child: Stars(rating: averageRating),
                ),
                Container(
                  // width: 235.w,
                  padding: EdgeInsets.only(
                    left: 10.w,
                    top: 5.h,
                  ),
                  child: Text(
                    'N ${product.price}',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  // width: 235.w,
                  padding: EdgeInsets.only(
                    left: 10.w,
                    top: 2.h,
                  ),
                  child: const Text(
                    'Eligible for free shipping',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  // width: 235.w,
                  padding: EdgeInsets.only(
                    left: 10.w,
                    top: 5.h,
                  ),
                  child: const Text(
                    'In Stock',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
