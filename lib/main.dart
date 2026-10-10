import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/core/di/service_locator.dart';
import 'package:waheed_hassan_suits/core/routing/app_router.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';

import 'core/storage/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  setupServiceLocator();
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
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          title: 'Waheed Hassan Suits',

          locale: const Locale('ar'),

          supportedLocales: const [Locale('ar')],

          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          theme: ThemeData(
            fontFamily: "IBMPlexSansArabic",
            splashFactory: NoSplash.splashFactory,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              enableFeedback: false,
              selectedLabelStyle: AppTextStyles.font14Regular,
              unselectedLabelStyle: AppTextStyles.font14Regular.copyWith(
                color: Color(0xff919191),
              )
            ),
            scaffoldBackgroundColor: Color(0xffF3F3F4),
            filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xff000000),
                foregroundColor: const Color(0xffffffff),
                fixedSize: Size.fromHeight(55.h),
                textStyle: AppTextStyles.font14MediumBlack.copyWith(
                  color: const Color(0xffffffff),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                fixedSize: Size.fromHeight(55.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff314158),
                textStyle: AppTextStyles.font14Regular,
              ),
            ),
            inputDecorationTheme: InputDecorationThemeData(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xffEAEAEA),
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xffEAEAEA),
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              hintStyle: AppTextStyles.font14RegularGrey,
            ),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
