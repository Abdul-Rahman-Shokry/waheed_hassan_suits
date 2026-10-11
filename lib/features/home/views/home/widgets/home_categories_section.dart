part of '../home_view.dart';

class _HomeCategoriesSection extends StatelessWidget {
  final VoidCallback? onSeeAllTap;
  final ValueChanged<CategoryModel>? onCategoryTap;

  const _HomeCategoriesSection({
    this.onSeeAllTap,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "تسوق حسب التصنيف",
              style: AppTextStyles.font16Bold,
            ),
            GestureDetector(
              onTap: onSeeAllTap,
              child: Text(
                "عرض الكل",
                style: AppTextStyles.font12Medium,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.categoriesState == DataState.loading &&
                state.categories.isEmpty) {
              return SizedBox(
                height: 140.h,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                ),
              );
            }

            if (state.categoriesState == DataState.failed &&
                state.categories.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Center(
                  child: TextButton.icon(
                    onPressed: () {
                      context
                          .read<HomeCubit>()
                          .getCategories(forceRefresh: true);
                    },
                    icon:
                        const Icon(Icons.refresh_rounded, color: Colors.black),
                    label: Text(
                      "تعذر تحميل التصنيفات، اضغط لإعادة المحاولة",
                      style: AppTextStyles.font12Medium,
                    ),
                  ),
                ),
              );
            }

            final categories = state.categories.length > 4
                ? state.categories.take(4).toList()
                : state.categories;

            if (categories.isEmpty) {
              return SizedBox(
                height: 64.h,
                child: Center(
                  child: Text(
                    "لا توجد تصنيفات حالياً",
                    style: AppTextStyles.font14MediumBlack,
                  ),
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                mainAxisExtent: 64.h,
              ),
              itemBuilder: (context, index) {
                final item = categories[index];
                return _buildCategoryCard(
                  title: item.displayName,
                  iconPath: item.displayIcon,
                  onTap: () => onCategoryTap?.call(item),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: 64.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xffEAEAEA), width: 1.w),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font14MediumBlack,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xffEAEAEA),
                        width: 1.w,
                      ),
                    ),
                    child: Center(
                      child: _buildCategoryIcon(iconPath),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
    return Icon(Icons.category_outlined, size: 20.r, color: Colors.grey);
  }
}
