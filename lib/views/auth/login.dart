import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/core/utils/helper_methods.dart';
import 'package:waheed_hassan_suits/core/widgets/app_button.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';
import 'package:waheed_hassan_suits/core/widgets/app_input.dart';
import 'package:waheed_hassan_suits/views/auth/register.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "تسجيل دخول",
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
                        text: "ليس لديك حساب ؟ ",
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {
                                goTo(page: RegisterView(), canPop: true);
                              },
                              child: Text("إنشاء حساب جديد"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("البريد الإلكتروني"),
                    SizedBox(height: 8.h),
                    AppInput(
                      hint: "name@example.com",
                      suffixIcon: "sms.svg",
                      bottomSpace: 8.h,
                    ),
                    Text("كلمة المرور"),
                    SizedBox(height: 8.h),
                    AppInput(
                      hint: "كلمة المرور",
                      isPassword: true,
                      bottomSpace: 8.h,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "هل نسيت كلمة المرور ؟",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    AppButton(text: "تسجيل الدخول"),
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
                          onTap: (){},
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
                          onTap: (){},
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
          ],
        ),
      ),
    );
  }
}
