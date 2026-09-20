part of '../forgot_password_view.dart';

class _ForgotPasswordStepThree extends StatefulWidget {
  const _ForgotPasswordStepThree();

  @override
  State<_ForgotPasswordStepThree> createState() => _ForgotPasswordStepThreeState();
}

class _ForgotPasswordStepThreeState extends State<_ForgotPasswordStepThree> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 12.h),
          Text(
            "كلمة المرور",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1F2937),
            ),
          ),
          SizedBox(height: 8.h),
          AppInput(
            hint: "••••••••",
            isPassword: true,
            controller: _newPasswordController,
            // TODO: uncomment
            // validator: AppValidators.password,
          ),
          SizedBox(height: 20.h),
          Text(
            "تأكيد كلمة المرور",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1F2937),
            ),
          ),
          SizedBox(height: 8.h),
          AppInput(
            hint: "••••••••",
            isPassword: true,
            controller: _confirmPasswordController,
            // TODO: uncomment
            // validator: AppValidators.password,
          ),
          const Spacer(),
          BlocBuilder<ForgotPasswordCubit, DataState>(
            builder: (context, state) {
              if (state == DataState.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return AppButton(
                text: "تأكيد كلمة المرور الجديدة",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<ForgotPasswordCubit>().resetPassword(
                      newPassword: _newPasswordController.text,
                      confirmNewPassword: _confirmPasswordController.text,
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}