import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/core/widgets/app_button.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 24.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "إطلالة تليق بك",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h,),
                  const Text(
                    "تسوّق أو استأجر بدلتك المفضلة بخطوات بسيطة\nوتجربة فاخرة.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff314158),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  AppButton(text: "البدء الآن"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}