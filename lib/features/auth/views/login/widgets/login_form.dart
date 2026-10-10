part of '../login_view.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "تسجيل دخول",
                textAlign: TextAlign.center,
                style: AppTextStyles.font24SemiBold,
              ),
              SizedBox(height: 4.h),
              Text.rich(
                textAlign: TextAlign.center,
                style: AppTextStyles.font14Regular,
                TextSpan(
                  text: "ليس لديك حساب ؟ ",
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          context.pushReplacement(AppRouter.register);
                        },
                        child: Text("إنشاء حساب جديد", style: AppTextStyles.font14Bold,),
                      ),
                    ),
                  ],
                ),
              ),
              Text("البريد الإلكتروني", style: AppTextStyles.font12Regular,),
              SizedBox(height: 8.h),
              AppInput(
                  hint: "name@example.com",
                  suffixIcon: "sms.svg",
                  bottomSpace: 8.h,
                  // TODO: don't forget to uncomment this
                  // validator: AppValidators.email,
                  controller: _emailController
              ),
              Text("كلمة المرور", style: AppTextStyles.font12Regular,),
              SizedBox(height: 8.h),
              AppInput(
                hint: "كلمة المرور",
                isPassword: true,
                bottomSpace: 8.h,
                // validator: AppValidators.password,
                controller: _passwordController,
              ),
              Row(
                children: [
                  // AppButton(text: "هل نسيت كلمة المرور ؟",),
                  TextButton(
                    onPressed: () {
                      context.push(AppRouter.forgotPassword);
                    },
                    child: Text(
                      "هل نسيت كلمة المرور ؟",
                      style: AppTextStyles.font12Regular,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              BlocBuilder<LoginCubit, DataState>(
                builder: (context, state) {
                  if (state == DataState.loading){
                    return const Center(child: CircularProgressIndicator());
                  }
                  return AppButton(
                    text: "تسجيل الدخول",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginCubit>().login(
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                        );
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(child: Divider()),
                  SizedBox(width: 12.w),
                  Text(
                    "أو تـــــــابــع بواسطة",
                    style: AppTextStyles.font12Regular.copyWith(
                      color: const Color(0xff939393),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 179.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffEAEAEA),
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Google",
                            style: AppTextStyles.font14Regular.copyWith(
                              color: const Color(0xff0A0A0A),
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          AppImage("google.svg"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 179.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffEAEAEA),
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Apple",
                            style: AppTextStyles.font14Regular.copyWith(
                              color: const Color(0xff0A0A0A),
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          AppImage("apple.svg"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
