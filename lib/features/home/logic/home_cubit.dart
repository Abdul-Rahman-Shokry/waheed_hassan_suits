import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/enums/data_state.dart';
import '../models/product_model.dart';
import '../repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(const HomeState());

  Future<void> getProducts({
    int pageIndex = 1,
    int pageSize = 10,
    int? categoryId,
    String? search,
    String? sort,
    double? minPrice,
    double? maxPrice,
  }) async {
    emit(state.copyWith(productsState: DataState.loading));

    final response = await _homeRepository.getProducts(
      pageIndex: pageIndex,
      pageSize: pageSize,
      categoryId: categoryId,
      search: search,
      sort: sort,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );

    if (response.isSuccess && response.successData != null) {
      final productModel = ProductModel.fromJson(response.successData);
      emit(
        state.copyWith(
          productsState: DataState.success,
          products: productModel.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          productsState: DataState.failed,
          errorMessage: response.errorMsg ?? "حدث خطأ أثناء تحميل المنتجات",
        ),
      );
    }
  }
}