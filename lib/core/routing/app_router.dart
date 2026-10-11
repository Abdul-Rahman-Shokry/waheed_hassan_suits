import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waheed_hassan_suits/core/di/service_locator.dart';
import 'package:waheed_hassan_suits/features/auth/views/register/widgets/register_success.dart';
import 'package:waheed_hassan_suits/features/home/logic/home_cubit.dart';
import 'package:waheed_hassan_suits/features/home/models/category_model.dart';
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
  AppRouter._();

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
          String title = "كل المنتجات";
          int? categoryId;

          final extra = state.extra;
          if (extra is CategoryModel) {
            title = extra.displayName.isNotEmpty
                ? extra.displayName
                : "كل المنتجات";
            categoryId = extra.id;
          } else if (extra is String) {
            title = extra;
          } else if (extra is int) {
            categoryId = extra;
          } else if (extra is Map<String, dynamic>) {
            title = (extra['categoryTitle'] ?? extra['title'] ?? extra['nameAr']) as String? ?? "كل المنتجات";
            categoryId = (extra['categoryId'] ?? extra['id']) as int?;
          } else if (extra is Map) {
            title = (extra['categoryTitle'] ?? extra['title'] ?? extra['nameAr'])?.toString() ?? "كل المنتجات";
            categoryId = (extra['categoryId'] ?? extra['id']) as int?;
          }

          if (categoryId == null && state.uri.queryParameters['categoryId'] != null) {
            categoryId = int.tryParse(state.uri.queryParameters['categoryId']!);
          }
          if (state.uri.queryParameters['title'] != null) {
            title = state.uri.queryParameters['title']!;
          }

          return AllProductsView(
            categoryTitle: title,
            categoryId: categoryId,
          );
        },
      ),
      GoRoute(
        path: allCategories,
        builder: (context, state) {
          final cubit = state.extra as HomeCubit?;
          if (cubit != null) {
            return BlocProvider.value(
              value: cubit..getCategories(),
              child: const AllCategoriesView(),
            );
          }
          return BlocProvider(
            create: (context) => sl<HomeCubit>()..getCategories(),
            child: const AllCategoriesView(),
          );
        },
      ),
      GoRoute(
        path: productDetails,
        builder: (context, state) {
          final extraData = state.extra;
          ProductData product;
          HomeCubit? cubit;

          if (extraData is Map<String, dynamic>) {
            product = extraData['product'] as ProductData;
            cubit = extraData['cubit'] as HomeCubit?;
          } else {
            product = extraData as ProductData;
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
              value: cubit..getWishlist(),
              child: const WishlistView(),
            );
          }
          return BlocProvider(
            create: (context) => sl<HomeCubit>()..getWishlist(),
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
                path: orders,
                builder: (context, state) => const OrdersView(),
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
