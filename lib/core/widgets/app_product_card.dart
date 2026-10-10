import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';
import '../../features/home/models/product_model.dart';

class AppProductCard extends StatelessWidget {
  final Data product;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const AppProductCard({
    super.key,
    required this.product,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xffEAEAEA),
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
                  child: product.mainImageUrl.startsWith('http')
                      ? Image.network(
                    product.mainImageUrl,
                    width: double.infinity,
                    height: 175.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(
                          height: 175.h,
                          color: const Color(0xffF0F0F0),
                          child: const Center(
                            child: Icon(
                              Icons.broken_image_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                  )
                      : AppImage(
                    product.mainImageUrl,
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
                          isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          size: 20.r,
                          color: isFavorite ? Colors.red : Colors.black,
                        ),
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
                        product.averageRating.toString(),
                        style: AppTextStyles.font12Regular,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "(${product.reviewCount})",
                        style: AppTextStyles.font10Regular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    product.nameAr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font14BoldBlack,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    product.categoryName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font11Regular,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "${product.price.toInt()} ج.م",
                    style: AppTextStyles.font16Regular,
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