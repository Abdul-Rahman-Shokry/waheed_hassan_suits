import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/enums/data_state.dart';
import 'package:waheed_hassan_suits/core/routing/app_router.dart';
import 'package:waheed_hassan_suits/core/widgets/app_product_card.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';
import '../../../logic/home_cubit.dart';
import '../../../logic/home_state.dart';

class SimilarProductsSection extends StatelessWidget {
  const SimilarProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xffEAEAEA), width: 1.w),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: const Color(0xffD4A054),
                      size: 20.r,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "منتجات مشابهة",
                      style: AppTextStyles.font16Bold,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    context.push(AppRouter.allProducts, extra: "كل المنتجات");
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "عرض الكل",
                        style: AppTextStyles.font12Medium.copyWith(
                          fontSize: 13.sp,
                          color: const Color(0xff757575),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 13.r,
                        color: const Color(0xff757575),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.productsState == DataState.loading &&
                    state.products.isEmpty) {
                  return SizedBox(
                    height: 295.h,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    ),
                  );
                }

                if (state.products.isEmpty) {
                  return const SizedBox.shrink();
                }

                return SizedBox(
                  height: 295.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.products.length,
                    separatorBuilder: (context, index) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      final item = state.products[index];
                      return SizedBox(
                        width: 175.w,
                        child: AppProductCard(
                          product: item,
                          isFavorite: state.favoriteProductIds.contains(
                            item.id,
                          ),
                          onTap: () {
                            context.push(
                              AppRouter.productDetails,
                              extra: {
                                'product': item,
                                'cubit': context.read<HomeCubit>(),
                              },
                            );
                          },
                          onFavoriteTap: () {
                            context.read<HomeCubit>().toggleWishlist(item.id);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
