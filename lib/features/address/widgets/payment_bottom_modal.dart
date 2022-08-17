import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:dart_g2_stores/shared/widgets/custom_button.dart';
import 'package:dart_g2_stores/shared/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';


class PaymentBottomModal extends StatelessWidget {
  final VoidCallback confirmPayment;
  const PaymentBottomModal({
    Key? key,
    required this.confirmPayment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return SizedBox(
      height: 300.h,
      child: Padding(
        padding: EdgeInsets.all(15.h),
        child: Column(
          children: [
            Spc(h: 10.h),
            Text(
              'Pay Total Amount',
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
           Spc(h: 20.h),
            Container(
              color: Colors.white24,
              height: 1,
            ),
            Spc(h: 20.h),
            Text(
              'N $sum',
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.blue02,
              ),
            ),
            Spc(h: 30.h),
            CustomButton(
              color: AppColors.primaryBlue,
              text: 'Confirm Payment',
              onTap: confirmPayment,
            )
          ],
        ),
      ),
    );
  }
}
