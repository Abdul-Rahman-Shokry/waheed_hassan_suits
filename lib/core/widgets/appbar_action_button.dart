import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppBarActionButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;

  const AppBarActionButton({super.key, required this.icon,  this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
              () {
            if (context.canPop()) {
              context.pop();
            }
          },
      child: Container(
        padding: EdgeInsetsDirectional.all(12.r),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          shape: BoxShape.circle,
          border: Border.fromBorderSide(
            BorderSide(color: Color(0xFFECECEC), width: 2.w),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x0F000000),
              offset: Offset(0, 1),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: icon,
      ),
    );
  }
}
