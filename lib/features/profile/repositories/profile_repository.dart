import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';

class ProfileRepository {
  final DioClient _dioClient;

  ProfileRepository(this._dioClient);

  Future<CustomResponse> logout() async {
    final response = await _dioClient.postData(
      ApiEndpoints.logout,
    );

    return response;
  }

  Future<CustomResponse> deleteAccount(String userId) async {
    final response = await _dioClient.deleteData(
      ApiEndpoints.deleteAccount(userId),
    );

    return response;
  }
}