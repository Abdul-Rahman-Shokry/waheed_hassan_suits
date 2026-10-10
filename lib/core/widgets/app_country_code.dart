import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/app_text_style.dart';


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
                style: AppTextStyles.font14RegularGrey,
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