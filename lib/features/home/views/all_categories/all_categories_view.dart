import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/routing/app_router.dart';
import 'package:waheed_hassan_suits/core/widgets/app_back.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';

class AllCategoriesView extends StatelessWidget {
  const AllCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      (title: "قمصان", icon: "shirt.svg"),
      (title: "بدلات", icon: "suit.svg"),
      (title: "أحذية", icon: "shoe.svg"),
      (title: "اكسسوارات", icon: "tie.svg"),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.white,
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
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            height: 68.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xffEAEAEA), width: 1.w),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: () {
                  context.push(AppRouter.allProducts, extra: category.title);
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
                            color: const Color(0xffEAEAEA),
                            width: 1.w,
                          ),
                        ),
                        child: Center(
                          child: AppImage(
                            category.icon,
                            width: 24.r,
                            height: 24.r,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        category.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
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
  }
}
