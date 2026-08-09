import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_image.dart';

class AppCountryCode extends StatefulWidget {
  const AppCountryCode({super.key});

  @override
  State<AppCountryCode> createState() => _AppCountryCodeState();
}

class _AppCountryCodeState extends State<AppCountryCode> {
  late int selectedCountryCode;
  final list = [10, 20, 30, 40, 50];

  @override
  void initState() {
    super.initState();
    selectedCountryCode = list.first;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(
            context,
          ).inputDecorationTheme.enabledBorder!.borderSide.color,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: DropdownButton<int>(
          icon: Padding(
            padding: EdgeInsetsDirectional.only(start: 6.w),
            child: AppImage(
              "down.svg",
              width: 10.w,
              height: 7.h,
              fit: BoxFit.fill,
            ),
          ),
          value: selectedCountryCode,
          items: list
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: Text(
                "$e",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
              ),
            ),
          )
              .toList(),
          onChanged: (value) {
            selectedCountryCode = value!;
            setState(() {});
          },
        ),
      ),
    );
  }
}