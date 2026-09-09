import 'package:dio/dio.dart';

import '../../features/auth/views/login_view.dart';
import '../storage/cache_helper.dart';
import '../utils/helper_methods.dart';
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
      goTo(page: LoginView(), canPop: false);
    }

    handler.next(err);
  }
}