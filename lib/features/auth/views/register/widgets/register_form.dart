part of '../register_view.dart';

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({super.key});

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "إنشاء حساب",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: "لديك حساب بالفعل ؟ ",
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.pushReplacement(AppRouter.login);
                          }
                        },
                        child: Text("تسجيل دخول"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Text("الاسم بالكامل"),
              SizedBox(height: 8.h),
              AppInput(
                hint: "اكتب اسمك بالكامل",
                suffixIcon: "profile.svg",
                bottomSpace: 8.h,
                controller: _nameController,
              ),
              Text("رقم الهاتف"),
              Directionality(
                textDirection: TextDirection.ltr,
                child: SizedBox(
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),
                      AppInput(
                        hint: "102233558",
                        suffixIcon: "call.svg",
                        withCountryCode: false,
                        bottomSpace: 8.h,
                        controller: _phoneController,
                      ),
                    ],
                  ),
                ),
              ),

              Text("البريد الإلكتروني"),
              SizedBox(height: 8.h),
              AppInput(
                hint: "name@example.com",
                bottomSpace: 8.h,
                suffixIcon: "sms.svg",
                controller: _emailController,
              ),
              Text("كلمة المرور"),
              SizedBox(height: 8.h),
              AppInput(
                hint: "********",
                isPassword: true,
                bottomSpace: 8.h,
                controller: _passwordController,
              ),
              Text("تأكيد كلمة المرور"),
              SizedBox(height: 8.h),
              AppInput(
                hint: "********",
                isPassword: true,
                bottomSpace: 24.h,
                controller: _confirmPasswordController,
              ),
              BlocBuilder<RegisterCubit, DataState>(
                builder: (context, state) {
                  if (state == DataState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return AppButton(
                    text: "إنشاء حساب",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<RegisterCubit>().register(
                          fullName: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          phoneNumber: _phoneController.text.trim(),
                          password: _passwordController.text.trim(),
                          confirmPassword: _confirmPasswordController.text
                              .trim(),
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
                    style: TextStyle(fontSize: 12.sp, color: Color(0xff939393)),
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
                            style: TextStyle(
                              color: Color(0xff0A0A0A),
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
                            style: TextStyle(
                              color: Color(0xff0A0A0A),
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
