part of '../profile_view.dart';

class _ProfileAccountActions extends StatelessWidget {
  const _ProfileAccountActions();

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
          child: _buildSettingsTile(
            svgPath: "trash.svg",
            title: 'حذف الحساب',
            isDeleteAccountTile: true,
            onTap: () {
              DeleteAccountBottomSheet.show(
                context,
                onConfirmDelete: () {
                  context.read<ProfileCubit>().deleteAccount();
                },
              );
            },
          ),
        ),
        SizedBox(height: 32.h),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoggingOut || state is ProfileDeletingAccount) {
              return const Center(child: CircularProgressIndicator());
            }
            return Row(
              children: [
                Expanded(
                  child: AppButton(
                    onPressed: () {
                      context.read<ProfileCubit>().logout();
                    },
                    text: "تسجيل الخروج",
                    bgColor: const Color(0xffFF4B4B).withValues(alpha: .25),
                    textColor: const Color(0xffFF4B4B),
                    iconPath: "logout.svg",
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // TODO: make it a shared widget
  Widget _buildSettingsTile({
    bool isDeleteAccountTile = false,
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
              decoration: BoxDecoration(
                color: isDeleteAccountTile
                    ? Color(0xffFF4B4B).withValues(alpha: .20)
                    : Color(0xffECECEC),
                shape: BoxShape.circle,
              ),
              child: svgPath != null
                  ? Center(
                      child: AppImage(
                        svgPath,
                        width: 22.r,
                        height: 22.r,
                        color: isDeleteAccountTile
                            ? Colors.red
                            : Color(0xff4A4A4A),
                      ),
                    )
                  : Icon(
                      icon,
                      size: 22.r,
                      color: isDeleteAccountTile
                          ? Colors.red
                          : Color(0xff4A4A4A),
                    ),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: isDeleteAccountTile ? Colors.red : Color(0xff000000),
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
                color: isDeleteAccountTile ? Colors.red : Color(0xff292D32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
