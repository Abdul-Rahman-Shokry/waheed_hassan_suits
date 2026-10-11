import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/core/theming/app_colors.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';
import '../../models/wishlist_item_model.dart';

class WishlistItemCard extends StatelessWidget {
  final WishlistItemModel item;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const WishlistItemCard({
    super.key,
    required this.item,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount =
        item.discountPrice != null && item.discountPrice! > 0 && item.discountPrice! < item.price;
    final double finalPrice = hasDiscount ? item.discountPrice! : item.price;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.border,
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15.r),
                  ),
                  child: AppImage(
                    item.mainImageUrl,
                    width: double.infinity,
                    height: 175.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xffF0F0F0),
                          width: 1.w,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.favorite_rounded,
                          size: 20.r,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ),
                ),
                if (item.isCustomizable)
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB89562),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        "تفصيل",
                        style: AppTextStyles.font10Regular.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 10.w,
                vertical: 8.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xffFFCC00),
                        size: 18,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        item.averageRating.toString(),
                        style: AppTextStyles.font12Regular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    item.productNameAr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font14MediumBlack,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Text(
                        "${finalPrice.toInt()} ج.م",
                        style: AppTextStyles.font16Regular,
                      ),
                      if (hasDiscount) ...[
                        SizedBox(width: 8.w),
                        Text(
                          "${item.price.toInt()} ج.م",
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.lightGray,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
