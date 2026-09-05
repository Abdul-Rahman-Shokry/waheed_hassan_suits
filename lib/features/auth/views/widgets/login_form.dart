part of '../login_view.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm({super.key});

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  // TODO: remove the fixed input text
  final _emailController = TextEditingController(text: "abdelrahman3457+1@gmail.com");
  final _passwordController = TextEditingController(text: "AbdoSh1030!");

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "تسجيل دخول",
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
              style: TextStyle(fontSize: 12.sp),
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
                        goTo(page: RegisterView(), canPop: true);
                      },
                      child: Text("إنشاء حساب جديد"),
                    ),
                  ),
                ],
              ),
            ),
            Text("البريد الإلكتروني"),
            SizedBox(height: 8.h),
            AppInput(
                hint: "name@example.com",
                suffixIcon: "sms.svg",
                bottomSpace: 8.h,
                // TODO: don't forget to uncomment this
                // validator: AppValidators.email,
                controller: _emailController
            ),
            Text("كلمة المرور"),
            SizedBox(height: 8.h),
            AppInput(
              hint: "كلمة المرور",
              isPassword: true,
              bottomSpace: 8.h,
              validator: AppValidators.password,
              controller: _passwordController,
            ),
            Row(
              children: [
                // AppButton(text: "هل نسيت كلمة المرور ؟",),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "هل نسيت كلمة المرور ؟",
                    style: TextStyle(fontSize: 14.sp),
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
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Color(0xff939393),
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
    );
  }
}
