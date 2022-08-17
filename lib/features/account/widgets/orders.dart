import 'dart:ui';

import 'package:dart_g2_stores/features/account/services/account_services.dart';
import 'package:dart_g2_stores/features/order_details/screens/order_details_screen.dart';
import 'package:dart_g2_stores/models/order.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:dart_g2_stores/shared/widgets/loader.dart';
import 'package:dart_g2_stores/shared/widgets/order_product.dart';
import 'package:dart_g2_stores/shared/widgets/single_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            shrinkWrap: true,
            itemCount: orders!.length,
            padding: EdgeInsets.only(left: 40.w, right: 20.w),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 30.h),
                height: 160.h,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OrderDetailsScreen.routeName,
                      arguments: orders![index],
                    );
                  },
                  child: Positioned(
                    bottom: 19.h,
                    right: 20.w,
                    child: OrderProduct(
                      productImage: orders![index].products[0].images[0],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
