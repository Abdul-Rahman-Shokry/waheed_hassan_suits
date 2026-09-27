import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/storage/cache_helper.dart';
import 'package:waheed_hassan_suits/core/utils/helper_methods.dart';
import 'package:waheed_hassan_suits/core/widgets/app_button.dart';
import 'package:waheed_hassan_suits/features/profile/logic/profile_cubit.dart';
import 'package:waheed_hassan_suits/features/profile/logic/profile_state.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/widgets/app_image.dart';

part './widgets/profile_guest_header.dart';

part './widgets/profile_user_header.dart';

part './widgets/profile_personal_settings.dart';

part './widgets/profile_common_settings.dart';

part './widgets/profile_account_actions.dart';

part './widgets/delete_account_bottom_sheet.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text("حسابي"), centerTitle: true),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLogoutSuccess) {
              showMsg("You logged out");
              context.go(AppRouter.login);
            } else if (state is ProfileLogoutFailed) {
              showMsg(state.message, isError: true);
            } else if (state is ProfileDeleteAccountSuccess) {
              showMsg("تم حذف الحساب بنجاح");
              context.go(AppRouter.login);
            } else if (state is ProfileDeleteAccountFailed) {
              showMsg(state.message, isError: true);
            }
          },
          builder: (context, state) {
            final isGuest = state is ProfileGuest;

            return SingleChildScrollView(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 16.w,
                vertical: 25.h,
              ),
              child: Column(
                children: [
                  if (isGuest)
                    const _ProfileGuestHeader()
                  else ...[
                    const _ProfileUserHeader(),
                    SizedBox(height: 16.h),
                    const _ProfilePersonalSettings(),
                  ],
                  SizedBox(height: 16.h),
                  const _ProfileCommonSettings(),
                  if (!isGuest) ...[
                    SizedBox(height: 16.h),
                    const _ProfileAccountActions(),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
