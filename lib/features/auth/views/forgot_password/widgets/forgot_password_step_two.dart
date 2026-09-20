part of '../forgot_password_view.dart';

class _ForgotPasswordStepTwo extends StatefulWidget {
  final VoidCallback onNext;

  const _ForgotPasswordStepTwo({required this.onNext});

  @override
  State<_ForgotPasswordStepTwo> createState() => _ForgotPasswordStepTwoState();
}

class _ForgotPasswordStepTwoState extends State<_ForgotPasswordStepTwo> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = context.read<ForgotPasswordCubit>().userEmail;

    final defaultPinTheme = PinTheme(
      width: 45.w,
      height: 45.h,
      textStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
        color: const Color(0xff434C6D),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.w),
        borderRadius: BorderRadius.circular(8.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.red, width: 1.5.w),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.red, width: 1.5.w),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 12.h),
        Text(
          "رمز التحقق",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "تم إرسال الرمز إلى $email",
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF6B7280),
          ),
        ),
        SizedBox(height: 32.h),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Pinput(
            controller: _otpController,
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            showCursor: true,
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 2.w, height: 24.h, color: Colors.grey),
              ],
            ),
          ),
        ),
        const Spacer(),
        AppButton(
          text: "تحقق ومتابعه",
          onPressed: () {
            if (_otpController.text.length == 6) {
              context.read<ForgotPasswordCubit>().otpCode = _otpController.text;
              widget.onNext();
            } else {
              showMsg("يرجى إدخال رمز التحقق كاملاً", isError: true);
            }
          },
        ),
      ],
    );
  }
}