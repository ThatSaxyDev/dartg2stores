import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dart_g2_stores/features/admin/models/sales.dart';
import 'package:dart_g2_stores/features/admin/services/admin_services.dart';
import 'package:dart_g2_stores/features/admin/widgets/category_products_chart.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:dart_g2_stores/shared/widgets/loader.dart';
import 'package:dart_g2_stores/shared/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Row(
                children: [
                  Text(
                    'Total Sales: ',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'N $totalSales',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  )
                ],
              ),
              Spc(h: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                  vertical: 2.h,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 2.h,
                    ),
                    height: 250.h,
                    child: CategoryProductsChart(
                      seriesList: [
                        charts.Series(
                          id: 'Sales',
                          data: earnings!,
                          domainFn: (Sales sales, _) => sales.label,
                          measureFn: (Sales sales, _) => sales.earning,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
