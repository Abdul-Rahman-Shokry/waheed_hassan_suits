import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';
import 'package:waheed_hassan_suits/features/home/models/product_model.dart';

class ProductDetailsInfoContainer extends StatefulWidget {
  final String productName;
  final String productDescription;
  final String categoryName;
  final double averageRating;
  final int reviewCount;
  final List<ProductColors> colors;
  final ValueChanged<ProductColors>? onColorSelected;

  const ProductDetailsInfoContainer({
    super.key,
    required this.productName,
    required this.productDescription,
    this.categoryName = '',
    this.averageRating = 0.0,
    this.reviewCount = 0,
    this.colors = const [],
    this.onColorSelected,
  });

  factory ProductDetailsInfoContainer.fromProduct({
    Key? key,
    required ProductData product,
    ValueChanged<ProductColors>? onColorSelected,
  }) {
    return ProductDetailsInfoContainer(
      key: key,
      productName: product.nameAr,
      productDescription: product.descriptionAr,
      categoryName: product.categoryName,
      averageRating: product.averageRating,
      reviewCount: product.reviewCount,
      colors: product.colors,
      onColorSelected: onColorSelected,
    );
  }

  @override
  State<ProductDetailsInfoContainer> createState() =>
      _ProductDetailsInfoContainerState();
}

class _ProductDetailsInfoContainerState
    extends State<ProductDetailsInfoContainer> {
  int _selectedColorIndex = 0;

  static final List<ProductColors> _fallbackColors = [
    ProductColors(colorNameAr: "رصاصي داكن", colorHex: "#39414B"),
    ProductColors(colorNameAr: "كحلي", colorHex: "#1C2852"),
    ProductColors(colorNameAr: "أسود", colorHex: "#1A1A1A"),
    ProductColors(colorNameAr: "بيج", colorHex: "#C6B299"),
  ];

  final List<String> _featuresTags = [
    "خياطة يدوية",
    "بطانة حريرية",
    "قصة سليم فيت",
  ];

  List<ProductColors> get _effectiveColors =>
      widget.colors.isNotEmpty ? widget.colors : _fallbackColors;

  int get _safeSelectedColorIndex {
    if (_effectiveColors.isEmpty) return 0;
    if (_selectedColorIndex >= _effectiveColors.length) return 0;
    return _selectedColorIndex;
  }

  Color _parseColor(String hex) {
    try {
      String cleanHex = hex.replaceAll("#", "").trim();
      if (cleanHex.startsWith("0x") || cleanHex.startsWith("0X")) {
        cleanHex = cleanHex.substring(2);
      }
      if (cleanHex.length == 6) {
        cleanHex = "FF$cleanHex";
      }
      if (cleanHex.length == 8) {
        return Color(int.parse("0x$cleanHex"));
      }
    } catch (_) {}
    return const Color(0xff1A1A1A);
  }

  @override
  Widget build(BuildContext context) {
    final colorsList = _effectiveColors;
    final selectedIndex = _safeSelectedColorIndex;
    final selectedColor =
        colorsList.isNotEmpty ? colorsList[selectedIndex] : null;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xffEAEAEA), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.categoryName.isNotEmpty
                ? widget.categoryName
                : "بدلة كلاسيكية",
            style: AppTextStyles.font14Regular.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xffC59A5A),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            widget.productName,
            textAlign: TextAlign.right,
            style: AppTextStyles.font20Bold,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "(${widget.reviewCount} تقييم)",
                style: AppTextStyles.font14Regular.copyWith(
                  fontSize: 13.sp,
                  color: const Color(0xff8C8C8C),
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                widget.averageRating.toStringAsFixed(1),
                style: AppTextStyles.font14MediumBlack.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4.w),
              const Icon(
                Icons.star_rounded,
                color: Color(0xffD4A054),
                size: 20,
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Row(
            children: [
              Expanded(
                child: _buildFeatureCard(
                  icon: Icons.shield_outlined,
                  title: "ضمان التفصيل",
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _buildFeatureCard(
                  icon: Icons.local_shipping_outlined,
                  title: "توصيل 3-7 أيام",
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _buildFeatureCard(
                  icon: Icons.workspace_premium_outlined,
                  title: "جودة عالية",
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: const Divider(
              color: Color(0xffF2F2F2),
              thickness: 1,
              height: 1,
            ),
          ),
          if (colorsList.isNotEmpty) ...[
            Text(
              "اللون",
              style: AppTextStyles.font16Bold,
            ),
            SizedBox(height: 10.h),
            if (selectedColor != null && selectedColor.colorNameAr.isNotEmpty)
              Text(
                selectedColor.colorNameAr,
                style: AppTextStyles.font14Regular.copyWith(
                  fontSize: 13.sp,
                  color: const Color(0xff737373),
                  fontWeight: FontWeight.w500,
                ),
              ),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(colorsList.length, (index) {
                final isSelected = selectedIndex == index;
                final colorItem = colorsList[index];
                final color = _parseColor(colorItem.colorHex);
                final checkColor =
                    ThemeData.estimateBrightnessForColor(color) ==
                            Brightness.dark
                        ? Colors.white
                        : Colors.black;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColorIndex = index;
                    });
                    widget.onColorSelected?.call(colorItem);
                  },
                  child: Container(
                    margin: EdgeInsetsDirectional.only(
                      start: index == 0 ? 0 : 12.w,
                    ),
                    width: 42.r,
                    height: 42.r,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xff000000)
                            : const Color(0xffE0E0E0),
                        width: isSelected ? 2.w : 1.w,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                            child: Icon(
                              Icons.check_rounded,
                              color: checkColor,
                              size: 22.r,
                            ),
                          )
                        : null,
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: const Divider(
                color: Color(0xffF2F2F2),
                thickness: 1,
                height: 1,
              ),
            ),
          ],
          Text(
            "الوصف",
            style: AppTextStyles.font16Bold,
          ),
          SizedBox(height: 10.h),
          Text(
            widget.productDescription.isNotEmpty
                ? widget.productDescription
                : "لا يوجد وصف متوفر لهذا المنتج حالياً.",
            textAlign: TextAlign.right,
            style: AppTextStyles.font14Regular.copyWith(
              height: 1.6,
              color: const Color(0xff4A5568),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _featuresTags.map((tag) {
              return Container(
                margin: EdgeInsetsDirectional.only(start: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xffFAF6F0),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  tag,
                  style: AppTextStyles.font12Medium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffB58C5A),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({required IconData icon, required String title}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xffEFEFEF), width: 1.2.w),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24.r, color: const Color(0xff2D3748)),
          SizedBox(height: 8.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.font12Medium.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xff2D3748),
            ),
          ),
        ],
      ),
    );
  }
}
