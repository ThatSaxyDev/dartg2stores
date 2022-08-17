import 'package:dart_g2_stores/provider/user_provider.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            // gradient: GlobalVariables.appBarGradient,
            color: Colors.transparent,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Hello, ',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: user.name,
                      style: TextStyle(
                        fontSize: 23.sp,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Divider(
                height: 1,
                endIndent: 10.w,
                color: AppColors.primaryBlue,
              ),
            ),
            Text(
              'Your Orders',
              style: TextStyle(
                  fontSize: 19.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: Divider(
                height: 1,
                indent: 10.w,
                color: AppColors.primaryBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
