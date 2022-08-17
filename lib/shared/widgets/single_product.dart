import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dart_g2_stores/shared/widgets/spacer.dart';

class SingleProduct extends StatefulWidget {
  final VoidCallback onTap;
  final String productImage;
  final String productName;
  const SingleProduct({
    Key? key,
    required this.onTap,
    required this.productImage,
    required this.productName,
  }) : super(key: key);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
                  widget.productImage,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Spc(h: 18.h),
          Text(
            widget.productName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
