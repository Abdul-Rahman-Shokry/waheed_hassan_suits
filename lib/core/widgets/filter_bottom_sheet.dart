import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';
import 'package:waheed_hassan_suits/core/widgets/app_button.dart';
import '../../features/home/logic/home_cubit.dart';
import '../../features/home/logic/home_state.dart';
import '../enums/data_state.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit..getCategories(),
        child: const FilterBottomSheet(),
      ),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int? _selectedCategoryId;
  late RangeValues _priceRange;

  @override
  void initState() {
    super.initState();
    final state = context.read<HomeCubit>().state;
    _selectedCategoryId = state.selectedCategoryId;
    _priceRange = RangeValues(
      state.minPrice ?? 0,
      state.maxPrice ?? 5000,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            int activeCount = 0;
            if (_selectedCategoryId != null) activeCount++;
            if (_priceRange.start > 0 || _priceRange.end < 5000) activeCount++;

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 44.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: const Color(0xffD0D5DD),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.close_rounded,
                            size: 24.r,
                            color: const Color(0xff667085),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "تصفية المنتجات",
                            style: AppTextStyles.font18Bold,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "$activeCount فلتر مفّعل",
                            style: AppTextStyles.font14Regular.copyWith(
                              fontSize: 13.sp,
                              color: const Color(0xff757575),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategoryId = null;
                              _priceRange = const RangeValues(0, 5000);
                            });
                            context.read<HomeCubit>().resetFilters();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            textDirection: TextDirection.ltr,
                            children: [
                              Text(
                                "إعادة التعيين",
                                style: AppTextStyles.font14Regular.copyWith(
                                  color: const Color(0xff667085),
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.restart_alt_rounded,
                                size: 20.r,
                                color: const Color(0xff667085),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "الأقسام",
                      style: AppTextStyles.font16Bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  if (state.categoriesState == DataState.loading)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      ),
                    )
                  else
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Wrap(
                        spacing: 8.w,
                        runSpacing: 10.h,
                        children: [
                          _buildCategoryChip(
                            title: "الكل",
                            isSelected: _selectedCategoryId == null,
                            onTap: () {
                              setState(() {
                                _selectedCategoryId = null;
                              });
                            },
                          ),
                          ...state.categories.map((category) {
                            final isSelected =
                                _selectedCategoryId == category.id;
                            return _buildCategoryChip(
                              title: category.nameAr,
                              isSelected: isSelected,
                              onTap: () {
                                setState(() {
                                  _selectedCategoryId = category.id;
                                });
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  SizedBox(height: 24.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "نطاق السعر",
                      style: AppTextStyles.font16Bold.copyWith(
                        color: const Color(0xff1E293B),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 3.h,
                      activeTrackColor: const Color(0xff334155),
                      inactiveTrackColor: const Color(0xffE2E8F0),
                      overlayColor: Colors.transparent,
                      rangeThumbShape: const _CustomRangeThumbShape(),
                    ),
                    child: RangeSlider(
                      values: _priceRange,
                      min: 0,
                      max: 5000,
                      onChanged: (values) {
                        setState(() {
                          _priceRange = values;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildPriceBox(
                            label: "الأدنى",
                            price: "${_priceRange.start.toInt()} ج.م",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Container(
                            width: 32.w,
                            height: 1.5.h,
                            color: const Color(0xffCBD5E1),
                          ),
                        ),
                        Expanded(
                          child: _buildPriceBox(
                            label: "الأعلى",
                            price: "${_priceRange.end.toInt()} ج.م",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  AppButton(
                    text: "عرض النتائج",
                    onPressed: () {
                      final double? minPrice =
                          _priceRange.start > 0 ? _priceRange.start : null;
                      final double? maxPrice =
                          _priceRange.end < 5000 ? _priceRange.end : null;

                      context.read<HomeCubit>().applyFilters(
                            categoryId: _selectedCategoryId,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                          );
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPriceBox({required String label, required String price}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.font12Medium.copyWith(
              color: const Color(0xff64748B),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            price,
            style: AppTextStyles.font16Bold,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : const Color(0xffF9FAFB),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Colors.black : const Color(0xffE5E7EB),
            width: 1.w,
          ),
        ),
        child: Text(
          title,
          style: AppTextStyles.font14MediumBlack.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xff4B5563),
          ),
        ),
      ),
    );
  }
}

class _CustomRangeThumbShape extends RangeSliderThumbShape {
  static const double _radius = 11.0;
  static const double _borderWidth = 3.0;
  static const Color _borderColor = Color(0xff334155);
  static const Color _fillColor = Colors.white;

  const _CustomRangeThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      const Size.fromRadius(_radius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;
    final Paint fillPaint = Paint()
      ..color = _fillColor
      ..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..color = _borderColor
      ..strokeWidth = _borderWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, _radius, fillPaint);
    canvas.drawCircle(center, _radius, borderPaint);
  }
}