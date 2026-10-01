import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';

class HomeRepository {
  final DioClient _dioClient;

  HomeRepository(this._dioClient);

  Future<CustomResponse> getProducts({
    int pageIndex = 1,
    int pageSize = 10,
    int? categoryId,
    String? search,
    String? sort,
    double? minPrice,
    double? maxPrice,
  }) async {
    final Map<String, dynamic> queryParameters = {
      'PageIndex': pageIndex,
      'PageSize': pageSize,
    };

    if (categoryId != null) queryParameters['CategoryId'] = categoryId;
    if (search != null && search.isNotEmpty) queryParameters['Search'] = search;
    if (sort != null && sort.isNotEmpty) queryParameters['Sort'] = sort;
    if (minPrice != null) queryParameters['MinPrice'] = minPrice;
    if (maxPrice != null) queryParameters['MaxPrice'] = maxPrice;

    return await _dioClient.getData(
      ApiEndpoints.products,
      queryParameters: queryParameters,
    );
  }
}