import 'package:dart_g2_stores/features/account/services/account_services.dart';
import 'package:dart_g2_stores/features/admin/screens/analytics_screen.dart';
import 'package:dart_g2_stores/features/admin/screens/orders_screen.dart';
import 'package:dart_g2_stores/features/admin/screens/products_screen.dart';
import 'package:dart_g2_stores/provider/user_provider.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_images.dart';
import 'package:dart_g2_stores/shared/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
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

  int _page = 0;
  double bottomNavBarWidth = 42.w;
  double bottomBorderWidth = 5.w;

  List<Widget> pages = [
    const ProductsScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              // gradient: GlobalVariables.appBarGradient,
              color: AppColors.blue02,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 240.w,
                //color: Colors.black,
                alignment: Alignment.topLeft,
                child: Image.asset(
                  AppImages.logo,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Seller',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spc(w: 20.w),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _page,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.grey,
        backgroundColor: Colors.transparent,
        iconSize: 26.sp,
        onTap: updatePage,
        items: [
          //HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color:
                        _page == 0 ? AppColors.primaryBlue : Colors.transparent,
                    width: bottomBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                _page == 0 ? Icons.home_filled : Icons.home_outlined,
              ),
            ),
            label: '',
          ),

          // ANALYTICS
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color:
                        _page == 1 ? AppColors.primaryBlue : Colors.transparent,
                    width: bottomBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                _page == 1 ? Icons.analytics : Icons.analytics_outlined,
              ),
            ),
            label: '',
          ),

          // ORDERS
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color:
                        _page == 2 ? AppColors.primaryBlue : Colors.transparent,
                    width: bottomBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                _page == 2 ? Icons.inbox : Icons.inbox_outlined,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
