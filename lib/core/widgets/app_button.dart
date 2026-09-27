import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';

class AppButton extends StatelessWidget {
  final String text;
  final String? iconPath;
  final Color? bgColor, textColor;
  final VoidCallback? onPressed;
  final bool isOutlinedButton;

  const AppButton({
    super.key,
    this.text = "",
    this.onPressed,
    this.bgColor,
    this.textColor,
    this.iconPath = "",
    this.isOutlinedButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return isOutlinedButton
        ? OutlinedButton(
            onPressed: onPressed ?? (){},
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xff1F2937),
              ),
            ),
          )
        : FilledButton(
            style: FilledButton.styleFrom(backgroundColor: bgColor),
            onPressed: onPressed ?? () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: textColor,
                  ),
                ),
                if (iconPath != null && iconPath!.isNotEmpty) ...[
                  SizedBox(width: 12.w),
                  AppImage(iconPath!, height: 24.h, width: 24.w),
                ],
              ],
            ),
          );
  }
}
