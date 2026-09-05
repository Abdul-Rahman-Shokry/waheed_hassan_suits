import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waheed_hassan_suits/core/enums/data_state.dart';
import 'package:waheed_hassan_suits/core/network/dio_client.dart';
import 'package:waheed_hassan_suits/core/storage/cache_helper.dart';
import 'package:waheed_hassan_suits/core/utils/helper_methods.dart';
import 'package:waheed_hassan_suits/core/utils/validators.dart';
import 'package:waheed_hassan_suits/core/widgets/app_button.dart';
import 'package:waheed_hassan_suits/core/widgets/app_image.dart';
import 'package:waheed_hassan_suits/core/widgets/app_input.dart';
import 'package:waheed_hassan_suits/features/auth/repositories/auth_repository.dart';
import 'package:waheed_hassan_suits/features/auth/views/register_view.dart';

import '../view_models/login_cubit.dart';

part 'widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(AuthRepository(DioClient())),
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
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
                child: BlocListener<LoginCubit, DataState>(
                  listener: (context, state) {
                    if (state == DataState.success){
                      showMsg("Login Success");
                      if (kDebugMode){
                        final response = context.read<LoginCubit>().responseData;
                        debugPrint("token:\n ${CacheHelper.token}");
                        debugPrint("Message: ${response?["message"]}");
                      }
                    } else if (state == DataState.failed){
                      final error = context.read<LoginCubit>().errorMessage;
                      showMsg(error ?? "حدث خطأ غير متوقع", isError: true);
                    }
                  },
                  child: _LoginForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
