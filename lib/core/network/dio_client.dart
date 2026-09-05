import 'package:dio/dio.dart';

import '../../features/auth/views/login_view.dart';
import '../storage/cache_helper.dart';
import '../utils/helper_methods.dart';
import 'api_endpoints.dart';

class DioClient {
  final _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  );

  DioClient();

  Future<CustomResponse> postData(
      String endpoint, {
        Map<String, dynamic>? body,
        bool withToken = false,
      }) async {
    Map<String, dynamic> requestHeaders = {};
    if (withToken) {
      requestHeaders["Authorization"] =
      CacheHelper.token != null ? "Bearer ${CacheHelper.token}" : null;
    }

    try {
      final resp = await _dio.post(
        endpoint,
        data: body,
        options: Options(headers: requestHeaders),
      );

      if (resp.statusCode != null &&
          resp.statusCode! >= 200 &&
          resp.statusCode! < 300) {
        return CustomResponse(isSuccess: true, successData: resp.data);
      }

      return CustomResponse(isSuccess: false);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        CacheHelper.clearSharedPrefs();
        goTo(page: LoginView(), canPop: false);

        return CustomResponse(
          isSuccess: false,
          errorMsg: "Session expired. Please login again.",
          errorStatusCode: 401,
        );
      }

      String? errorMessage;
      if (e.response?.data != null && e.response?.data is Map) {
        errorMessage = e.response?.data["message"];
      } else {
        errorMessage = e.message;
      }

      return CustomResponse(
        isSuccess: false,
        errorMsg: errorMessage,
        errorStatusCode: e.response?.statusCode,
      );
    } catch (e) {
      return CustomResponse(isSuccess: false, errorMsg: "Unexpected Error");
    }
  }

  Future<CustomResponse> getData(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        bool withToken = false,
      }) async {
    Map<String, dynamic> requestHeaders = {};
    if (withToken) {
      requestHeaders["Authorization"] =
      CacheHelper.token != null ? "Bearer ${CacheHelper.token}" : null;
    }

    try {
      final resp = await _dio.get(
        endpoint,
        options: Options(headers: requestHeaders),
        queryParameters: queryParameters,
      );

      Map<String, dynamic> data;
      if (resp.data is List) {
        data = {"list": resp.data};
      } else {
        data = resp.data;
      }

      if (resp.statusCode != null &&
          resp.statusCode! >= 200 &&
          resp.statusCode! < 300) {
        return CustomResponse(isSuccess: true, successData: data);
      } else {
        return CustomResponse(isSuccess: false);
      }
    } on DioException catch (e) {
      String? errorMessage;
      if (e.response?.data != null && e.response?.data is Map) {
        errorMessage = e.response?.data["message"];
      } else {
        errorMessage = e.message;
      }

      return CustomResponse(
        isSuccess: false,
        errorMsg: errorMessage,
        errorStatusCode: e.response?.statusCode,
      );
    } catch (e) {
      return CustomResponse(isSuccess: false, errorMsg: "Unexpected Error");
    }
  }
}

class CustomResponse {
  final bool isSuccess;
  final String? errorMsg;
  final int? errorStatusCode;
  final dynamic successData;

  CustomResponse({
    required this.isSuccess,
    this.errorMsg,
    this.successData,
    this.errorStatusCode,
  });
}