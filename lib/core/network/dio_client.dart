import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_endpoints.dart';
import 'app_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final Dio _dio;

  DioClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      ) {
    _dio.interceptors.add(AppInterceptor());
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
  }) async {
    try {
      final resp = await _dio.get(endpoint, queryParameters: queryParameters);

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