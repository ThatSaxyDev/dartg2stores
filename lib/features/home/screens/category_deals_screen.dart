import 'package:dart_g2_stores/features/home/services/home_services.dart';
import 'package:dart_g2_stores/features/product_details/screens/product_details_screen.dart';
import 'package:dart_g2_stores/models/product.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:dart_g2_stores/shared/widgets/loader.dart';
import 'package:dart_g2_stores/shared/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
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
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text(
            widget.category,
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 10.h,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.category}',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryBlue),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    //height: Dimensions.height10 * 17,
                    child: GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      shrinkWrap: true,
                      itemCount: productList!.length,
                      //scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 15.w),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        //childAspectRatio: 2,
                        //mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final product = productList![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProductDetailsScreen.routeName,
                              arguments: product,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 140.h,
                                width: 140.w,
                                child: PhysicalModel(
                                  color: Colors.white,
                                  elevation: 15,
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: Image.network(
                                      product.images[0],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                // child: Padding(
                                //   padding: EdgeInsets.symmetric(
                                //     horizontal: 10.w,
                                //     vertical: 10.h,
                                //   ),
                                //   child: Image.network(
                                //     product.images[0],
                                //   ),
                                // ),
                              ),
                              Spc(h: 18.h),
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
