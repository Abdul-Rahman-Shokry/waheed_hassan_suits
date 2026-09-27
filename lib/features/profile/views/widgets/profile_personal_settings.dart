part of '../profile_view.dart';

class _ProfilePersonalSettings extends StatelessWidget {
  const _ProfilePersonalSettings();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              // TODO: consume these endpoints -> GET/PUT /api/Users/me
              _buildSettingsTile(
                svgPath: "active_profile.svg",
                title: 'تعديل الملف الشخصي',
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
                svgPath: 'heart.svg',
                title: 'المفضلة',
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
                svgPath: 'inactive_box.svg',
                title: 'طلباتي',
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
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff000000),
              ),
            ),
            const Spacer(),
            if (trailingText != null) ...[
              Text(
                trailingText,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff686868),
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
