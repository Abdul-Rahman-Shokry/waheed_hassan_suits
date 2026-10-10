import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';

class ProductDetailsActionBar extends StatelessWidget {
  final double price;
  final double discountPrice;
  final VoidCallback? onContinueTap;

  const ProductDetailsActionBar({
    super.key,
    required this.price,
    this.discountPrice = 0,
    this.onContinueTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount = discountPrice > 0 && discountPrice < price;
    final double finalPrice = hasDiscount ? discountPrice : price;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xffEAEAEA), width: 1.w),
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${finalPrice.toInt()} ج.م",
                style: AppTextStyles.font18Bold,
              ),
              if (hasDiscount)
                Text(
                  "${price.toInt()} ج.م",
                  style: AppTextStyles.font14Regular.copyWith(
                    fontSize: 13.sp,
                    color: const Color(0xff9E9E9E),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: FilledButton(
              onPressed: onContinueTap,
              child: const Text("متابعة"),
            ),
          ),
        ],
      ),
    );
  }
}
