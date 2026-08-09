import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_image.dart';

class AppCountryCode extends StatefulWidget {
  const AppCountryCode({super.key});

  @override
  State<AppCountryCode> createState() => _AppCountryCodeState();
}

class _AppCountryCodeState extends State<AppCountryCode> {
  late String selectedCountryCode;
  final list = ["+10", "+20", "+30", "+40", "+50"];

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
        child: DropdownButton<String>(
          icon: Padding(
            padding: EdgeInsetsDirectional.only(start: 6.w),
            child: SizedBox.shrink(),
          ),
          value: selectedCountryCode,
          items: list
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: Color(0xff939393),
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