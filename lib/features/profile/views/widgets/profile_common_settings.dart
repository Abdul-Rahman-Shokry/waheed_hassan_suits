part of '../profile_view.dart';

class _ProfileCommonSettings extends StatelessWidget {
  const _ProfileCommonSettings();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الإعدادات',
          style: AppTextStyles.font16Bold,
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              _buildSettingsTile(
                icon: Icons.language_rounded,
                title: 'اللغة',
                trailingText: 'الإنجليزية',
                onTap: () {},
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xffF5F5F5),
                ),
              ),
              _buildSettingsTile(
                svgPath: 'headphone.svg',
                title: 'مركز المساعدة',
                onTap: () {},
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              _buildSettingsTile(
                icon: Icons.description_outlined,
                title: 'الشروط والأحكام',
                onTap: () {},
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xffF5F5F5),
                ),
              ),
              _buildSettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'سياسة الخصوصية',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    IconData? icon,
    String? svgPath,
    required String title,
    String? trailingText,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: const BoxDecoration(
                color: Color(0xffECECEC),
                shape: BoxShape.circle,
              ),
              child: svgPath != null
                  ? Center(
                child: AppImage(
                  svgPath,
                  width: 22.r,
                  height: 22.r,
                  color: const Color(0xff4A4A4A),
                ),
              )
                  : Icon(
                icon,
                size: 22.r,
                color: const Color(0xff4A4A4A),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: AppTextStyles.font16Medium,
            ),
            const Spacer(),
            if (trailingText != null) ...[
              Text(
                trailingText,
                style: AppTextStyles.font16Regular.copyWith(
                  color: Color(0xff595959),
                ),
              ),
              SizedBox(width: 8.w),
            ],
            Transform.rotate(
              angle: math.pi,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16.r,
                color: const Color(0xff292D32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}