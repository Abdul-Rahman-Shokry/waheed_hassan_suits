import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/cache_helper.dart';
import '../models/login_request_body.dart';
import '../models/user_model.dart';

class AuthRepository {
  final DioClient _dioClient;

  AuthRepository(this._dioClient);

  Future<CustomResponse> login(LoginRequestBody body) async {
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
}