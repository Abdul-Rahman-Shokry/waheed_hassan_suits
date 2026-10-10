import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/core/theming/app_text_style.dart';
import '../../features/home/views/widgets/filter_bottom_sheet.dart';

class AppSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final String hintText;

  const AppSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onFilterTap,
    this.hintText = "البحث عن منتج...",
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Container(
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xffEAEAEA),
            width: 2.w,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.search_rounded,
              color: const Color(0xff9E9E9E),
              size: 24.r,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                controller: widget.controller,
                onChanged: widget.onChanged,
                onTapOutside: (event) {
                  _focusNode.unfocus();
                },
                style: AppTextStyles.font14Regular,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: widget.hintText,
                  hintStyle: AppTextStyles.font16Regular.copyWith(
                    color: const Color(0xff9E9E9E),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap:
                  widget.onFilterTap ?? () => FilterBottomSheet.show(context),
              child: Icon(
                Icons.tune_rounded,
                color: Colors.black,
                size: 22.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}