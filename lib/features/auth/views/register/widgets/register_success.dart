import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/routing/app_router.dart';
import 'package:waheed_hassan_suits/core/widgets/app_button.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';

class RegisterSuccess extends StatelessWidget {
  const RegisterSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.go(AppRouter.login);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppImage(
                    "success.json",
                    width: 220.w,
                    lottieSpeed: 0.4,
                    bottomSpace: 16.h,
                  ),
                  Text(
                    "تم إنشاء الحساب!",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: 260.w,
                    child: Text(
                      "حسابك جاهز الآن، ابدأ باكتشاف تشكيلتنا المميزة من البدل والقمصان.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF6B7280),
                        height: 1.4,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  AppButton(
                    text: "المتابعة لتسجيل الدخول",
                    onPressed: () => context.go(AppRouter.login),
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