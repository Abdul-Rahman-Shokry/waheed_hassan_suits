import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/views/auth/register.dart';

import 'core/utils/helper_methods.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          navigatorKey: navKey,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: "IBMPlexSansArabic",
            filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
                backgroundColor: Color(0xff000000),
                fixedSize: Size.fromHeight(55.h),
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xff314158),
                textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400)
              ),
            ),
            inputDecorationTheme: InputDecorationThemeData(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffEAEAEA), width: 1.w),
                borderRadius: BorderRadius.circular(12.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffEAEAEA), width: 1.w),
                borderRadius: BorderRadius.circular(12.r),
              ),
              hintStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff939393),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: RegisterView(),
    );
  }
}
