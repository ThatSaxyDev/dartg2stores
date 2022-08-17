import 'package:dart_g2_stores/features/admin/screens/add_product_screen.dart';
import 'package:dart_g2_stores/features/admin/services/admin_services.dart';
import 'package:dart_g2_stores/features/admin/widgets/seller_product.dart';
import 'package:dart_g2_stores/models/product.dart';
import 'package:dart_g2_stores/provider/user_provider.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:dart_g2_stores/shared/widgets/loader.dart';
import 'package:dart_g2_stores/shared/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product>? products = [];
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) async {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return products == null
        ? const Loader()
        : Scaffold(
            body: Padding(
              padding: EdgeInsets.only(
                top: 10.h,
                left: 5.w,
                right: 5.w,
              ),
              child: Column(
                children: [
                  Spc(h: 10.h),
                  RichText(
                    text: TextSpan(
                      text: 'Hello ',
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
                        TextSpan(
                          text: ', Your Products',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spc(h: 27.h),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 25.w),
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: products!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final productData = products![index];
                        return Column(
                          children: [
                            SellerProduct(
                              productImage: productData.images[0],
                              productName: productData.name,
                              onTap: () {},
                              onDelete: () => deleteProduct(productData, index),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.blue02,
              tooltip: 'Add a product',
              onPressed: navigateToAddProduct,
              child: const Icon(Icons.add),
            ),
          );
  }
}
