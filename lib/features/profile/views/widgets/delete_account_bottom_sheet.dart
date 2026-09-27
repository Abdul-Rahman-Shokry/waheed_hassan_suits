part of '../profile_view.dart';

class DeleteAccountBottomSheet extends StatefulWidget {
  final VoidCallback? onConfirmDelete;

  const DeleteAccountBottomSheet({super.key, this.onConfirmDelete});

  static Future<void> show(
    BuildContext context, {
    VoidCallback? onConfirmDelete,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          DeleteAccountBottomSheet(onConfirmDelete: onConfirmDelete),
    );
  }

  @override
  State<DeleteAccountBottomSheet> createState() =>
      _DeleteAccountBottomSheetState();
}

class _DeleteAccountBottomSheetState extends State<DeleteAccountBottomSheet> {
  bool _isAcknowledged = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 44.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xffD0D5DD),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            Center(
              child: Container(
                width: 72.w,
                height: 72.h,
                decoration: BoxDecoration(
                  color: const Color(0xffFEE4E2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.warning_rounded,
                    color: const Color(0xffD92D20),
                    size: 34.r,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            Text(
              "تأكيد حذف الحساب",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "سيتم حذف حسابك وجميع بياناتك بشكل نهائي ولا يمكن استعادتها.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff686868),
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () {
                setState(() {
                  _isAcknowledged = !_isAcknowledged;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xffF4F4F6),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "لقد فهمت أن هذا الإجراء نهائي.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff1F2937),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: Checkbox(
                        value: _isAcknowledged,
                        activeColor: const Color(0xff292D32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        side: const BorderSide(
                          color: Color(0xff98A2B3),
                          width: 1.5,
                        ),
                        onChanged: (val) {
                          setState(() {
                            _isAcknowledged = val ?? false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Delete Button (حذف الحساب)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: _isAcknowledged
                      ? const Color(0xffFF4B4B)
                      : const Color(0xffFF4B4B).withValues(alpha: 0.3),
                  disabledBackgroundColor: const Color(
                    0xffFF4B4B,
                  ).withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                onPressed: _isAcknowledged
                    ? () {
                        context.pop();
                        widget.onConfirmDelete?.call();
                      }
                    : null,
                child: Text(
                  "حذف الحساب",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Cancel Button (إلغاء)
            SizedBox(height: 8.h),
            AppButton(
              text: "إلغاء",
              isOutlinedButton: true,
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
