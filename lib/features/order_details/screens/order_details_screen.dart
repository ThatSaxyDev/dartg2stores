import 'package:dart_g2_stores/features/admin/services/admin_services.dart';
import 'package:dart_g2_stores/features/search/screens/search_screen.dart';
import 'package:dart_g2_stores/models/order.dart';
import 'package:dart_g2_stores/provider/user_provider.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_images.dart';
import 'package:dart_g2_stores/shared/widgets/custom_button.dart';
import 'package:dart_g2_stores/shared/widgets/search_bar.dart';
import 'package:dart_g2_stores/shared/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: query,
    );
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

//! ONLY FOR ADMIN
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(() {
          currentStep += 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppColors.blue02,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              // gradient: GlobalVariables.appBarGradient,
              color: Colors.transparent,
            ),
          ),
          title: user.type == 'admin'
              ? Container(
                  width: 240.w,
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    AppImages.logo,
                    color: Colors.white,
                  ),
                )
              : const SearchBar(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'View order details',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              Spc(h: 4.h),
              Container(
                padding: EdgeInsets.all(10.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[600]!,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Date:      ${DateFormat().format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.order.orderedAt),
                      )}',
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      'Order ID:           ${widget.order.id}',
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      'Order Total:      N ${widget.order.totalPrice}',
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Spc(h: 15.h),
              Text(
                'Purchase Details',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              Spc(h: 4.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[600]!,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120.h,
                            width: 120.w,
                          ),
                          Spc(w: 5.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spc(h: 5.h),
                                Text(
                                  'Qty: ${widget.order.quantity[i]}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Spc(h: 20.h),
              Center(
                child: Text(
                  'Tracking',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              Spc(h: 2.h),
              Stepper(
                physics: const ClampingScrollPhysics(),
                currentStep: currentStep,
                controlsBuilder: (context, details) {
                  if (user.type == 'admin') {
                    return currentStep == 3
                        ? const SizedBox()
                        : Padding(
                            padding: EdgeInsets.all(10.h),
                            child: CustomButton(
                              color: AppColors.primaryBlue,
                              text: 'Done',
                              onTap: () =>
                                  changeOrderStatus(details.currentStep),
                            ),
                          );
                  }
                  return const SizedBox();
                },
                steps: [
                  Step(
                      title: const Text('Pending'),
                      content: Text(
                        user.type == 'admin' ? '' : 'Your order is yet to be delivered',
                      ),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed),
                  Step(
                      title: const Text('Completed'),
                      content: Text(
                        user.type == 'admin' ? '' : 'Your order has been delivered, you are yet to sign',
                      ),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed),
                  Step(
                    title: const Text('Received'),
                    content: Text(
                      user.type == 'admin' ? '' : 'Your order has been delivered and signed by you',
                    ),
                    isActive: currentStep > 2,
                    state: currentStep > 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                      title: const Text('Delivered'),
                      content: Text(
                        user.type == 'admin' ? 'Order received and signed by customer' : 'Your order has been delivered and signed by you',
                      ),
                      isActive: currentStep >= 3,
                      state:
                          // currentStep >= 3?
                          StepState.complete
                      // : StepState.indexed,
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
