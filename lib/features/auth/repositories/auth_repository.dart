import 'package:waheed_hassan_suits/features/auth/models/forgot_password_request.dart';
import 'package:waheed_hassan_suits/features/auth/models/register_request_body.dart';
import 'package:waheed_hassan_suits/features/auth/models/reset_password_request.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/cache_helper.dart';
import '../models/login_request.dart';
import '../models/user_model.dart';

class AuthRepository {
  final DioClient _dioClient;

  AuthRepository(this._dioClient);

  Future<CustomResponse> login(LoginRequest body) async {
    final response = await _dioClient.postData(
      ApiEndpoints.login,
      body: body.toJson(),
    );

    if (response.isSuccess && response.successData != null) {
      final user = UserModel.fromJson(response.successData);
      await CacheHelper.saveUserData(model: user);
    }

    return response;
  }

  Future<CustomResponse> register(RegisterRequest body) async {
    final response = await _dioClient.postData(
      ApiEndpoints.register,
      body: body.toJson(),
    );

    if (response.isSuccess && response.successData != null) {
      final user = UserModel.fromJson(response.successData);
      await CacheHelper.saveUserData(model: user);
    }

    return response;
  }

  Future<CustomResponse> forgotPassword(ForgotPasswordRequest body) async {
    final response = await _dioClient.postData(
      ApiEndpoints.forgotPassword,
      body: body.toJson(),
    );

    return response;
  }

  Future<CustomResponse> resetPassword(ResetPasswordRequest body) async {
    final response = await _dioClient.postData(
      ApiEndpoints.resetPassword,
      body: body.toJson(),
    );

    return response;
  }
}