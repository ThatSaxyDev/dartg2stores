import 'package:badges/badges.dart';
import 'package:dart_g2_stores/features/account/screens/account_screen.dart';
import 'package:dart_g2_stores/features/cart/screens/cart_screen.dart';
import 'package:dart_g2_stores/features/home/screens/home_screen.dart';
import 'package:dart_g2_stores/provider/user_provider.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  double bottomNavBarWidth = 42.w;
  double bottomBorderWidth = 5.w;

  List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
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

          // CART
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
              child: Badge(
                elevation: 0,
                badgeContent: userCartLen == 0
                    ? const Text('')
                    : Text(userCartLen.toString()),
                // badgeColor: Colors.red[400]!,
                badgeColor: Colors.transparent,
                child: Icon(
                  _page == 1
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                ),
              ),
            ),
            label: '',
          ),

          // ACCOUNT, PROFILE
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
                _page == 2 ? Icons.person : Icons.person_outlined,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
