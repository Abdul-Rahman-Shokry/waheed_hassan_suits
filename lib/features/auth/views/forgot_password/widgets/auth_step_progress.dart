part of '../forgot_password_view.dart';

class AuthStepProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const AuthStepProgress({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "خطوة $currentStep / $totalSteps",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: List.generate(totalSteps, (index) {
            final isActive = index < currentStep;
            return Expanded(
              child: Container(
                height: 5.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: isActive ? Colors.black : const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}