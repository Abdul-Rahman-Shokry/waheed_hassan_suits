import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/features/auth/views/register/widgets/register_success.dart';
import '../../features/auth/views/forgot_password/forgot_password_view.dart';
import '../../features/auth/views/login/login_view.dart';
import '../../features/auth/views/register/register_view.dart';
import '../../features/cart/cart_view.dart';
import '../../features/home/home_view.dart';
import '../../features/main_layout/main_layout_view.dart';
import '../../features/onboarding.dart';
import '../../features/orders/orders_view.dart';
import '../../features/profile/profile_view.dart';
import '../../features/splash.dart';
import '../utils/helper_methods.dart';

class AppRouter {
  static const String splash = '/';
  static const String onBoarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verifyOtp = '/verify-otp';
  static const String registerSuccess = '/register-success';

  static const String home = '/home';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String profile = '/profile';

  static final GoRouter router = GoRouter(
    navigatorKey: navKey,
    initialLocation: home,
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
        path: registerSuccess,
        builder: (context, state) => const RegisterSuccess(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayoutView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: home,
                builder: (context, state) => const HomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: cart,
                builder: (context, state) => const CartView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: orders,
                builder: (context, state) => const OrdersView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: profile,
                builder: (context, state) => const ProfileView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}