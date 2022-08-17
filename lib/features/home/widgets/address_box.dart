import 'package:dart_g2_stores/provider/user_provider.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40.h,
      decoration: const BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [
        //     Color.fromARGB(255, 114, 226, 221),
        //     Color.fromARGB(255, 162, 236, 233),
        //   ],
        //   stops: [0.5, 1.0],
        // ),
        color: Colors.transparent,
      ),
      padding: EdgeInsets.only(left: 10.w),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
            color: AppColors.primaryBlue,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                'Delivery to ${user.name} - ${user.address}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 5.w,
              top: 2.h,
            ),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 24.w,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
