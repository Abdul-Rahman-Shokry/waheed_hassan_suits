part of '../forgot_password_view.dart';

class _ForgotPasswordStepOne extends StatefulWidget {
  const _ForgotPasswordStepOne();

  @override
  State<_ForgotPasswordStepOne> createState() => _ForgotPasswordStepOneState();
}

class _ForgotPasswordStepOneState extends State<_ForgotPasswordStepOne> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
            "نسيت كلمة المرور؟",
            style: AppTextStyles.font24Medium,
          ),
          SizedBox(height: 8.h),
          Text(
            "أدخل بريدك الإلكتروني لإرسال رمز تحقق آمن.",
            style: AppTextStyles.font16Regular,
          ),
          SizedBox(height: 32.h),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "البريد الإلكتروني",
              style: AppTextStyles.font14Medium,
            ),
          ),
          SizedBox(height: 8.h),
          AppInput(
            hint: "name@example.com",
            suffixIcon: "sms.svg",
            controller: _emailController,
            // TODO: uncomment
            // validator: AppValidators.email,
          ),
          const Spacer(),
          BlocBuilder<ForgotPasswordCubit, DataState>(
            builder: (context, state) {
              if (state == DataState.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return AppButton(
                text: "إرسال رابط",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<ForgotPasswordCubit>().forgotPassword(
                      email: _emailController.text.trim(),
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