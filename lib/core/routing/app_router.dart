import 'package:go_router/go_router.dart';
import '../../features/auth/views/forgot_password_view.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/register_view.dart';
import '../../features/auth/views/verify_otp.dart';
import '../../features/onboarding.dart';
import '../../features/splash.dart';
import '../utils/helper_methods.dart';

class AppRouter {
  static const String splash = '/';
  static const String onBoarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verifyOtp = '/verify-otp';

  static final GoRouter router = GoRouter(
    navigatorKey: navKey,
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: onBoarding,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: verifyOtp,
        builder: (context, state) => const VerifyOtpView(),
      ),
    ],
  );
}