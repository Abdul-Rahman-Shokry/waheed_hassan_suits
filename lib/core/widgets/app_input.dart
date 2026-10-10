import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';

import 'app_country_code.dart';
import 'app_image.dart';

class AppInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? suffixIcon, hint, label;
  final bool withCountryCode, isPassword;
  final double? bottomSpace;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextDirection? textDirection;

  const AppInput({
    super.key,
    this.suffixIcon,
    this.hint,
    this.label,
    this.withCountryCode = false,
    this.isPassword = false,
    this.bottomSpace,
    this.validator,
    this.controller,
    this.keyboardType,
    this.textDirection,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isHidden = true;

  bool get _isLtrOnly {
    if (widget.isPassword || widget.withCountryCode) {
      return true;
    }

    final keyboardType = widget.keyboardType;
    if (keyboardType == TextInputType.emailAddress ||
        keyboardType == TextInputType.number ||
        keyboardType == TextInputType.phone) {
      return true;
    }

    final hint = widget.hint?.trim() ?? '';
    final suffix = widget.suffixIcon?.trim() ?? '';

    final isEmail = hint.contains('@') ||
        hint.toLowerCase().contains('email') ||
        suffix == 'sms.svg';

    final isNumeric = suffix == 'call.svg' ||
        (hint.isNotEmpty && RegExp(r'^[0-9+\s-]+$').hasMatch(hint));

    return isEmail || isNumeric;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTextDirection = widget.textDirection ??
        (_isLtrOnly ? TextDirection.ltr : Directionality.of(context));

    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomSpace ?? 16.h),
      child: Row(
        children: [
          if (widget.withCountryCode) const AppCountryCode(),
          if (widget.withCountryCode) SizedBox(width: 6.w),
          Expanded(
            child: TextFormField(
              textDirection: effectiveTextDirection,
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              controller: widget.controller,
              obscureText: widget.isPassword && isHidden,
              decoration: InputDecoration(
                hintStyle: AppTextStyles.font14RegularGrey,
                hintText: widget.hint,
                labelText: widget.label,
                isDense: true,
                suffixIcon: widget.isPassword
                    ? IconButton(
                  onPressed: () {
                    isHidden = !isHidden;
                    setState(() {});
                  },
                  icon: AppImage(
                    isHidden ? "visibility.svg" : "visibility_off.svg",
                  ),
                )
                    : widget.suffixIcon != null
                    ? AppImage(widget.suffixIcon!, width: 18.w, height: 18.h)
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}