import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/di/service_locator.dart';
import 'package:waheed_hassan_suits/features/auth/views/register/widgets/register_success.dart';
import 'package:waheed_hassan_suits/features/home/logic/home_cubit.dart';
import 'package:waheed_hassan_suits/features/home/models/product_model.dart';
import 'package:waheed_hassan_suits/features/home/views/all_categories/all_categories_view.dart';
import 'package:waheed_hassan_suits/features/home/views/product_details/product_details_view.dart';
import 'package:waheed_hassan_suits/features/home/views/wishlist/wishlist_view.dart';
import '../../features/auth/views/forgot_password/forgot_password_view.dart';
import '../../features/auth/views/login/login_view.dart';
import '../../features/auth/views/register/register_view.dart';
import '../../features/cart/cart_view.dart';
import '../../features/home/views/all_products/all_products_view.dart';
import '../../features/home/views/home/home_view.dart';
import '../../features/main_layout/main_layout_view.dart';
import '../../features/onboarding.dart';
import '../../features/orders/orders_view.dart';
import '../../features/profile/views/profile_view.dart';
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
  static const String allProducts = '/all-products';
  static const String allCategories = '/all-categories';
  static const String wishlist = '/wishlist';
  static const String productDetails = '/product-details';

  static final GoRouter router = GoRouter(
    navigatorKey: navKey,
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashView()),
      GoRoute(
        path: onBoarding,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(path: login, builder: (context, state) => const LoginView()),
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
      GoRoute(
        path: allProducts,
        builder: (context, state) {
          final title = state.extra as String? ?? "كل المنتجات";
          return AllProductsView(categoryTitle: title);
        },
      ),
      GoRoute(
        path: allCategories,
        builder: (context, state) {
          return const AllCategoriesView();
        },
      ),
      GoRoute(
        path: productDetails,
        builder: (context, state) {
          final extraData = state.extra;
          Data product;
          HomeCubit? cubit;

          if (extraData is Map<String, dynamic>) {
            product = extraData['product'] as Data;
            cubit = extraData['cubit'] as HomeCubit?;
          } else {
            product = extraData as Data;
          }

          if (cubit != null) {
            return BlocProvider.value(
              value: cubit,
              child: ProductDetailsView(product: product),
            );
          }

          return BlocProvider(
            create: (context) => sl<HomeCubit>()..getProducts(),
            child: ProductDetailsView(product: product),
          );
        },
      ),
      GoRoute(
        path: wishlist,
        builder: (context, state) {
          final cubit = state.extra as HomeCubit?;
          if (cubit != null) {
            return BlocProvider.value(
              value: cubit,
              child: const WishlistView(),
            );
          }
          return BlocProvider(
            create: (context) => sl<HomeCubit>()..getProducts(),
            child: const WishlistView(),
          );
        },
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
