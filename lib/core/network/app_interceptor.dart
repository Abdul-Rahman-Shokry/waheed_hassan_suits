import 'package:dio/dio.dart';

import '../routing/app_router.dart';
import '../storage/cache_helper.dart';
import 'api_endpoints.dart';

class AppInterceptor extends Interceptor {
  final List<String> _publicEndpoints = [
    ApiEndpoints.login,
    ApiEndpoints.register,
  ];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final bool isPublic = _publicEndpoints.any(
          (endpoint) => options.path.contains(endpoint),
    );

    if (!isPublic && CacheHelper.token != null) {
      options.headers['Authorization'] = 'Bearer ${CacheHelper.token}';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      CacheHelper.clearSharedPrefs();
      AppRouter.router.go(AppRouter.login);
    }

    handler.next(err);
  }
}