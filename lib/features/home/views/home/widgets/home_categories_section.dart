part of '../home_view.dart';

class _HomeCategoriesSection extends StatelessWidget {
  final VoidCallback? onSeeAllTap;
  final ValueChanged<String>? onCategoryTap;

  const _HomeCategoriesSection({
    super.key,
    this.onSeeAllTap,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      (title: "بدلات", icon: "suit.svg"),
      (title: "قمصان", icon: "shirt.svg"),
      (title: "اكسسوارات", icon: "tie.svg"),
      (title: "أحذية", icon: "shoe.svg"),
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "تسوق حسب التصنيف",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: onSeeAllTap,
              child: Text(
                "عرض الكل",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff314158),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        GridView.builder(
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
              title: item.title,
              iconPath: item.icon,
              onTap: () => onCategoryTap?.call(item.title),
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
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
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
                      child: AppImage(iconPath, width: 24.r, height: 24.r),
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
}
