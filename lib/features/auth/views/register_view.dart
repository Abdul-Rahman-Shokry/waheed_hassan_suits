import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/features/auth/views/login_view.dart';

import '../../../core/utils/helper_methods.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_image.dart';
import '../../../core/widgets/app_input.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Positioned.fill(
              child: AppImage(
                "onboarding.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "إنشاء حساب",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text: "لديك حساب بالفعل ؟ ",
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {
                                  goTo(page: LoginView(), canPop: true);
                                },
                                child: Text("تسجيل دخول"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text("الاسم بالكامل"),
                      SizedBox(height: 8.h),
                      AppInput(
                        hint: "اكتب اسمك بالكامل",
                        suffixIcon: "profile.svg",
                        bottomSpace: 8.h,
                      ),
                      Text("رقم الهاتف"),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: SizedBox(
                          child: Column(
                            children: [
                              SizedBox(height: 8.h),
                              AppInput(
                                hint: "102233558",
                                suffixIcon: "call.svg",
                                withCountryCode: true,
                                bottomSpace: 8.h,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Text("البريد الإلكتروني"),
                      SizedBox(height: 8.h),
                      AppInput(
                        hint: "name@example.com",
                        bottomSpace: 8.h,
                        suffixIcon: "sms.svg",
                      ),
                      Text("كلمة المرور"),
                      SizedBox(height: 8.h),
                      AppInput(
                        hint: "********",
                        isPassword: true,
                        bottomSpace: 8.h,
                      ),
                      Text("تأكيد كلمة المرور"),
                      SizedBox(height: 8.h),
                      AppInput(
                        hint: "********",
                        isPassword: true,
                        bottomSpace: 24.h,
                      ),
                      AppButton(text: "إنشاء حساب"),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          SizedBox(width: 12.w),
                          Text(
                            "أو تـــــــابــع بواسطة",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xff939393),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 179.w,
                              height: 48.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffEAEAEA),
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Google",
                                    style: TextStyle(
                                      color: Color(0xff0A0A0A),
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  AppImage("google.svg"),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 179.w,
                              height: 48.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffEAEAEA),
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Apple",
                                    style: TextStyle(
                                      color: Color(0xff0A0A0A),
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  AppImage("apple.svg"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
