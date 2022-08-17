import 'package:dart_g2_stores/features/account/services/account_services.dart';
import 'package:dart_g2_stores/features/account/widgets/below_app_bar.dart';
import 'package:dart_g2_stores/features/account/widgets/orders.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_images.dart';
import 'package:dart_g2_stores/shared/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void logOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  AccountServices().logOut(context);
                },
                child: const Text(
                  'Yes',
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'No',
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: AppColors.blue02,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 240.w,
                alignment: Alignment.topLeft,
                child: Image.asset(
                  AppImages.logo,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () => logOut(context),
                child: Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: const Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Spc(h: 10.h),
          const BelowAppBar(),
          Spc(h: 20.h),
          const Expanded(
            child: Orders(),
          ),
        ],
      ),
    );
  }
}
