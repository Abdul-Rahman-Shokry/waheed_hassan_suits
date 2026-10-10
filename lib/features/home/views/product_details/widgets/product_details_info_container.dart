import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';

class ProductDetailsInfoContainer extends StatefulWidget {
  final String productName;
  final String productDescription;

  const ProductDetailsInfoContainer({
    super.key,
    required this.productName,
    required this.productDescription,
  });

  @override
  State<ProductDetailsInfoContainer> createState() =>
      _ProductDetailsInfoContainerState();
}

class _ProductDetailsInfoContainerState
    extends State<ProductDetailsInfoContainer> {
  int _selectedColorIndex = 0;

  final List<Map<String, dynamic>> _colors = [
    {"name": "رصاصي داكن", "color": const Color(0xff39414B)},
    {"name": "كحلي", "color": const Color(0xff1C2852)},
    {"name": "أسود", "color": const Color(0xff1A1A1A)},
    {"name": "بيج", "color": const Color(0xffC6B299)},
  ];

  final List<String> _featuresTags = [
    "خياطة يدوية",
    "بطانة حريرية",
    "قصة سليم فيت",
  ];

  @override
  Widget build(BuildContext context) {
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
            "بدلة كلاسيكية",
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
                "(124 تقييم)",
                style: AppTextStyles.font14Regular.copyWith(
                  fontSize: 13.sp,
                  color: const Color(0xff8C8C8C),
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                "4.8",
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
          Text(
            "اللون",
            style: AppTextStyles.font16Bold,
          ),
          SizedBox(height: 10.h),
          Text(
            _colors[_selectedColorIndex]["name"] as String,
            style: AppTextStyles.font14Regular.copyWith(
              fontSize: 13.sp,
              color: const Color(0xff737373),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(_colors.length, (index) {
              final isSelected = _selectedColorIndex == index;
              final color = _colors[index]["color"] as Color;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColorIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 12.w),
                  width: 42.r,
                  height: 42.r,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: isSelected
                      ? const Center(
                          child: Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 22,
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
          Text(
            "الوصف",
            style: AppTextStyles.font16Bold,
          ),
          SizedBox(height: 10.h),
          Text(
            widget.productDescription,
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
