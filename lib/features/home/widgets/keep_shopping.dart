import 'package:dart_g2_stores/features/home/services/home_services.dart';
import 'package:dart_g2_stores/features/product_details/screens/product_details_screen.dart';
import 'package:dart_g2_stores/models/product.dart';
import 'package:dart_g2_stores/shared/widgets/loader.dart';
import 'package:dart_g2_stores/shared/widgets/single_product.dart';
import 'package:dart_g2_stores/shared/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeepShopping extends StatefulWidget {
  const KeepShopping({
    Key? key,
  }) : super(key: key);

  @override
  State<KeepShopping> createState() => _KeepShoppingState();
}

class _KeepShoppingState extends State<KeepShopping> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: 'Mobiles',
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   body:
        productList == null
            ? const Loader()
            : Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: productList!.length,
                  padding: EdgeInsets.only(left: 15.w),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //childAspectRatio: 2,
                    // mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final product = productList![index];
                    return SingleProduct(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ProductDetailsScreen.routeName,
                          arguments: product,
                        );
                      },
                      productImage: product.images[0],
                      productName: product.name,
                    );
                  },
                ),
              );
  }
}
