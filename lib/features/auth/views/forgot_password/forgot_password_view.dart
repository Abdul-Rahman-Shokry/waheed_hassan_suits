import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:waheed_hassan_suits/core/enums/data_state.dart';
import 'package:waheed_hassan_suits/core/routing/app_router.dart';
import 'package:waheed_hassan_suits/core/utils/validators.dart';
import 'package:waheed_hassan_suits/core/widgets/app_back.dart';
import 'package:waheed_hassan_suits/features/auth/view_models/forgot_password_cubit.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/helper_methods.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';

part './widgets/auth_step_progress.dart';
part './widgets/forgot_password_step_one.dart';
part './widgets/forgot_password_step_two.dart';
part './widgets/forgot_password_step_three.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final PageController _pageController;
  int _currentStep = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      if (context.canPop()) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgotPasswordCubit>(),
      child: BlocListener<ForgotPasswordCubit, DataState>(
        listener: (context, state) {
          if (state == DataState.success) {
            if (_currentStep == 1) {
              showMsg("تم إرسال الرمز بنجاح");
              _nextStep();
            } else if (_currentStep == 3) {
              showMsg("تم تغيير كلمة المرور بنجاح");
              context.go(AppRouter.login);
            }
          } else if (state == DataState.failed) {
            final error = context.read<ForgotPasswordCubit>().errorMessage;
            showMsg(error ?? "حدث خطأ غير متوقع", isError: true);
          }
        },
        child: PopScope(
          canPop: _currentStep == 1,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            _previousStep();
          },
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: 68.w,
              leading: Padding(
                padding: EdgeInsetsDirectional.only(start: 16.w),
                child: AppBack(
                  onTap: _previousStep,
                ),
              ),
              title: const Text("نسيت كلمة المرور"),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  AuthStepProgress(
                    currentStep: _currentStep,
                    totalSteps: 3,
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: const Color(0xFFECECEC)),
                      ),
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const _ForgotPasswordStepOne(),
                          _ForgotPasswordStepTwo(onNext: _nextStep),
                          const _ForgotPasswordStepThree(),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}