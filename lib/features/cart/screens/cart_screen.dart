import 'package:dart_g2_stores/features/address/screens/address_screen.dart';
import 'package:dart_g2_stores/features/cart/widgets/cart_product.dart';
import 'package:dart_g2_stores/features/cart/widgets/cart_subtotal.dart';
import 'package:dart_g2_stores/features/home/widgets/address_box.dart';
import 'package:dart_g2_stores/features/search/screens/search_screen.dart';
import 'package:dart_g2_stores/provider/user_provider.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_images.dart';
import 'package:dart_g2_stores/shared/widgets/custom_button.dart';
import 'package:dart_g2_stores/shared/widgets/search_bar.dart';
import 'package:dart_g2_stores/shared/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: query,
    );
  }

  void navigateToAddressScreen(double sum) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: sum.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.blue02,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          title: const SearchBar(),
        ),
      ),
      body: user.cart.isEmpty
          ? Padding(
            padding: EdgeInsets.only(left: 30.h),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spc(h: 70.h),
                  SizedBox(
                    width: 300.w,
                    child: Image.asset(
                      AppImages.emptyCart,
                      color: AppColors.blue02,
                    ),
                  ),
                ],
              ),
          )
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  const AddressBox(),
                  const CartSubtotal(),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 8.w,
                      left: 120.w,
                      top: 15.h,
                      bottom: 8.h,
                    ),
                    child: CustomButton(
                      color: AppColors.primaryBlue,
                      text: user.cart.length == 1
                          ? 'Proceed to Buy ${user.cart.length} item'
                          : 'Proceed to Buy ${user.cart.length} items',
                      onTap: () => navigateToAddressScreen(sum),
                    ),
                  ),
                  Spc(h: 15.h),
                  Container(
                    color: Colors.grey[600],
                    height: 1,
                  ),
                  Spc(h: 15.h),
                  Text(
                    'Cart',
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spc(h: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.h),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: user.cart.length,
                      itemBuilder: (context, index) {
                        return CartProduct(index: index);
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
