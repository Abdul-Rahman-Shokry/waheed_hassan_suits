part of '../profile_view.dart';

class _ProfileUserHeader extends StatelessWidget {
  const _ProfileUserHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // TODO: use the "/api/Users/me" endpoint to show the profile image
        // if (CacheHelper.profileImageUrl)

        AppImage("person_80_80.svg", bottomSpace: 8.h,),
        Text(
          CacheHelper.fullName,
          maxLines: 1,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
