import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/enums/data_state.dart';
import 'package:waheed_hassan_suits/core/routing/app_router.dart';
import 'package:waheed_hassan_suits/core/theming/app_colors.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';
import 'package:waheed_hassan_suits/core/widgets/app_back.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';
import 'package:waheed_hassan_suits/features/home/logic/home_cubit.dart';
import 'package:waheed_hassan_suits/features/home/logic/home_state.dart';

class AllCategoriesView extends StatelessWidget {
  const AllCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          leadingWidth: 68.w,
          leading: Padding(
            padding: EdgeInsetsDirectional.only(start: 16.w),
            child: AppBack(
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
            ),
          ),
          title: Text(
            "التصنيفات",
            style: AppTextStyles.font18Bold,
          ),
          centerTitle: true,
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.categoriesState == DataState.loading &&
              state.categories.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state.categoriesState == DataState.failed &&
              state.categories.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 48.r,
                    color: AppColors.lightGray,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "تعذر تحميل التصنيفات",
                    style: AppTextStyles.font14MediumBlack,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<HomeCubit>()
                          .getCategories(forceRefresh: true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                    ),
                    child: const Text("إعادة المحاولة"),
                  ),
                ],
              ),
            );
          }

          if (state.categories.isEmpty) {
            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                await context
                    .read<HomeCubit>()
                    .getCategories(forceRefresh: true);
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 120.h),
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 48.r,
                          color: AppColors.lightGray,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "لا توجد تصنيفات حالياً",
                          style: AppTextStyles.font14MediumBlack,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              await context
                  .read<HomeCubit>()
                  .getCategories(forceRefresh: true);
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              itemCount: state.categories.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return Container(
                  height: 68.h,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border, width: 1.w),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        context.push(
                          AppRouter.allProducts,
                          extra: category,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Container(
                              width: 44.r,
                              height: 44.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.border,
                                  width: 1.w,
                                ),
                              ),
                              child: Center(
                                child: _buildCategoryIcon(category.displayIcon),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Text(
                                category.displayName,
                                style: AppTextStyles.font16SemiBold,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16.r,
                              color: AppColors.lightGray,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryIcon(String iconPath) {
    if (iconPath.isNotEmpty) {
      return AppImage(
        iconPath,
        width: 24.r,
        height: 24.r,
        fit: BoxFit.contain,
      );
    }
    return Icon(Icons.category_outlined, size: 20.r, color: AppColors.lightGray);
  }
}

