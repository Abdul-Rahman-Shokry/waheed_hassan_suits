import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_endpoints.dart';
import 'app_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final Dio _dio;

  DioClient({
    Duration connectTimeout = const Duration(seconds: 10),
    Duration receiveTimeout = const Duration(seconds: 10),
    Duration sendTimeout = const Duration(seconds: 10),
    AppInterceptor? appInterceptor,
    void Function()? onUnauthorized,
  }) : _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout,
          sendTimeout: sendTimeout,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      ) {
    _dio.interceptors.add(
      appInterceptor ?? AppInterceptor(onUnauthorized: onUnauthorized),
    );
    // if (kDebugMode) {
    //   _dio.interceptors.add(
    //     LogInterceptor(
    //       request: true,
    //       requestHeader: true,
    //       requestBody: true,
    //       responseHeader: false,
    //       responseBody: true,
    //       error: true,
    //     ),
    //   );
    // }
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          maxWidth: 40,
          compact: true
        ),
      );
    }
  }

  Future<CustomResponse> postData(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final resp = await _dio.post(endpoint, data: body);

      if (resp.statusCode != null &&
          resp.statusCode! >= 200 &&
          resp.statusCode! < 300) {
        return CustomResponse(isSuccess: true, successData: resp.data);
      }

      return CustomResponse(isSuccess: false);
    } on DioException catch (e) {
      final String? errorMessage = _extractErrorMessage(e);

      return CustomResponse(
        isSuccess: false,
        errorMsg: errorMessage,
        errorStatusCode: e.response?.statusCode,
      );
    } catch (e) {
      return CustomResponse(isSuccess: false, errorMsg: "Unexpected Error");
    }
  }

  Future<CustomResponse> getData<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final resp = await _dio.get<T>(endpoint, queryParameters: queryParameters);

      dynamic data;
      if (resp.data is List) {
        if (resp.data is T && T != dynamic) {
          data = resp.data;
        } else {
          data = {"list": resp.data};
        }
      } else if (resp.data is Map) {
        if (resp.data is Map<String, dynamic>) {
          data = resp.data;
        } else {
          data = Map<String, dynamic>.from(resp.data as Map);
        }
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
      final String? errorMessage = _extractErrorMessage(e);

      return CustomResponse(
        isSuccess: false,
        errorMsg: errorMessage,
        errorStatusCode: e.response?.statusCode,
      );
    } catch (e) {
      return CustomResponse(isSuccess: false, errorMsg: "Unexpected Error");
    }
  }

  Future<CustomResponse> deleteData(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body,
      }) async {
    try {
      final resp = await _dio.delete(
        endpoint,
        queryParameters: queryParameters,
        data: body,
      );

      if (resp.statusCode != null &&
          resp.statusCode! >= 200 &&
          resp.statusCode! < 300) {
        return CustomResponse(isSuccess: true, successData: resp.data);
      }

      return CustomResponse(isSuccess: false);
    } on DioException catch (e) {
      final String? errorMessage = _extractErrorMessage(e);

      return CustomResponse(
        isSuccess: false,
        errorMsg: errorMessage,
        errorStatusCode: e.response?.statusCode,
      );
    } catch (e) {
      return CustomResponse(isSuccess: false, errorMsg: "Unexpected Error");
    }
  }

  String? _extractErrorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final message = data["message"] ?? data["title"];
      if (message is String && message.isNotEmpty) return message;
    } else if (data is String && data.isNotEmpty) {
      return data;
    }
    final statusCode = e.response?.statusCode;
    if (statusCode != null) return "Error $statusCode";
    return e.message;
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

  T? dataAs<T>() => successData is T ? successData as T : null;
}