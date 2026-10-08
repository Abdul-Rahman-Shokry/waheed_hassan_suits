import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';
import 'package:waheed_hassan_suits/features/home/views/product_details/widgets/customizable_badge.dart';

class CustomizableProductImage extends StatelessWidget {
  final String imageUrl;
  final bool isCustomizable;
  final double? height;
  final double? width;
  final double borderRadius;

  const CustomizableProductImage({
    super.key,
    required this.imageUrl,
    this.isCustomizable = true,
    this.height,
    this.width,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: Stack(
        children: [
          SizedBox(
            width: width ?? double.infinity,
            height: height ?? 280.h,
            child: imageUrl.startsWith('http')
                ? Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: height ?? 280.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
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
                    imageUrl,
                    width: double.infinity,
                    height: height ?? 280.h,
                    fit: BoxFit.cover,
                  ),
          ),
          if (isCustomizable)
            Positioned(
              top: 12.h,
              right: 12.w,
              child: const CustomizableBadge(),
            ),
        ],
      ),
    );
  }
}
