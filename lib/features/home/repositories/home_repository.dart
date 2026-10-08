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
    if (minPrice != null && minPrice != 0) queryParameters['MinPrice'] = minPrice;
    if (maxPrice != null) queryParameters['MaxPrice'] = maxPrice;

    return await _dioClient.getData(
      ApiEndpoints.products,
      queryParameters: queryParameters,
    );
  }

  Future<CustomResponse> getCategories() async {
    return await _dioClient.getData(ApiEndpoints.categories);
  }

  Future<CustomResponse> getCategoryById(int id) async {
    return await _dioClient.getData(ApiEndpoints.category(id));
  }

  Future<CustomResponse> addToWishlist(int id) async {
    return await _dioClient.postData(ApiEndpoints.addToWishlist(id));
  }

  Future<CustomResponse> removeFromWishlist(int wishlistItemId) async {
    return await _dioClient.deleteData(
      ApiEndpoints.removeFromWishlist(wishlistItemId),
    );
  }

  Future<CustomResponse> getWishlist() async {
    return await _dioClient.getData(ApiEndpoints.wishlist);
  }

  Future<CustomResponse> checkWishlist(int id) async {
    return await _dioClient.getData(ApiEndpoints.checkWishlist(id));
  }
}
