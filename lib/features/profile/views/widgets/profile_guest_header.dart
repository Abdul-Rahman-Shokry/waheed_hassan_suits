part of '../profile_view.dart';

class _ProfileGuestHeader extends StatelessWidget {
  const _ProfileGuestHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16.w,
        vertical: 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text.rich(
              style: AppTextStyles.font16Medium,
              TextSpan(
                text: "أهلاً بيك في ",
                children: [
                  TextSpan(
                    text: "وحيد!",
                    style: AppTextStyles.font18Bold,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'هنسهل عليك شراء وتأجير البدَل وملابس المناسبات',
              style: AppTextStyles.font12Regular.copyWith(
                color: Color(0xff292D32)
              ),
            ),
          ),
          SizedBox(height: 20.h),
          InkWell(
            onTap: () async {
              await context.push(AppRouter.login);
              if (context.mounted) {
                context.read<ProfileCubit>().checkAuthStatus();
              }
            },
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              width: double.infinity,
              height: 52.h,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.r),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: 18.r,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'تسجيل الدخول / إنشاء حساب',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: Color(0xffFFFFFF)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}