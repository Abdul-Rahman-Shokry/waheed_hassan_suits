import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/features/auth/view_models/register_cubit.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/enums/data_state.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/helper_methods.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/app_input.dart';

part 'widgets/register_form.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterCubit>(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: AppImage(
                "onboarding.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocConsumer<RegisterCubit, DataState>(
                listener: (context, state) {
                  if (state == DataState.success){
                    showMsg("Register Success");
                  } else if (state == DataState.failed){
                    final error = context.read<RegisterCubit>().errorMessage;
                    showMsg(error ?? "حدث خطأ غير متوقع", isError: true);
                  }
                },
                builder: (context, state) {
                  return _RegisterForm();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
