import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/enums/data_state.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/wishlist_item_model.dart';
import '../repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;
  Timer? _debounce;

  HomeCubit(this._homeRepository) : super(const HomeState());

  void onSearchChanged(String text) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () {
        searchProducts(text);
      },
    );
  }

  Future<void> searchProducts(String query) async {
    final trimmed = query.trim();
    emit(state.copyWith(
      searchQuery: trimmed.isEmpty ? null : trimmed,
      clearSearch: trimmed.isEmpty,
    ));
    await getProducts(search: trimmed.isEmpty ? null : trimmed);
  }

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

    final effectiveCategoryId = categoryId ?? state.selectedCategoryId;
    final effectiveMinPrice = minPrice ?? state.minPrice;
    final effectiveMaxPrice = maxPrice ?? state.maxPrice;
    final effectiveSearch = search ?? state.searchQuery;

    final response = await _homeRepository.getProducts(
      pageIndex: pageIndex,
      pageSize: pageSize,
      categoryId: effectiveCategoryId,
      search: effectiveSearch,
      sort: sort,
      minPrice: effectiveMinPrice,
      maxPrice: effectiveMaxPrice,
    );

    if (response.isSuccess && response.successData != null) {
      final productModel = ProductModel.fromJson(response.successData);
      emit(
        state.copyWith(
          productsState: DataState.success,
          products: productModel.data,
        ),
      );
      await getWishlist();
    } else {
      emit(
        state.copyWith(
          productsState: DataState.failed,
          errorMessage: response.errorMsg ?? "حدث خطأ أثناء تحميل المنتجات",
        ),
      );
    }
  }

  Future<void> applyFilters({
    int? categoryId,
    double? minPrice,
    double? maxPrice,
  }) async {
    emit(
      state.copyWith(
        selectedCategoryId: categoryId,
        clearSelectedCategory: categoryId == null,
        minPrice: minPrice,
        maxPrice: maxPrice,
        clearPriceFilter: minPrice == null && maxPrice == null,
      ),
    );
    await getProducts(
      categoryId: categoryId,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }

  Future<void> resetFilters() async {
    emit(
      state.copyWith(
        clearSelectedCategory: true,
        clearPriceFilter: true,
      ),
    );
    await getProducts(
      categoryId: null,
      minPrice: null,
      maxPrice: null,
    );
  }

  Future<void> filterByCategory(int? categoryId) async {
    await applyFilters(
      categoryId: categoryId,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
    );
  }

  Future<void> getCategories() async {
    if (state.categories.isNotEmpty) return;

    emit(state.copyWith(categoriesState: DataState.loading));

    final response = await _homeRepository.getCategories();

    if (response.isSuccess && response.successData != null) {
      final data = response.successData as Map;
      final rawList = data['list'] ?? data['data'] ?? [];

      final categories = (rawList as List)
          .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
          .toList();

      emit(
        state.copyWith(
          categoriesState: DataState.success,
          categories: categories,
        ),
      );
    } else {
      emit(state.copyWith(categoriesState: DataState.failed));
    }
  }

  Future<void> checkWishlistForProducts(List<Data> products) async {
    if (products.isEmpty) return;

    final checkResponses = await Future.wait(
      products.map((product) => _homeRepository.checkWishlist(product.id)),
    );

    final updatedFavorites = Set<int>.from(state.favoriteProductIds);

    for (int i = 0; i < products.length; i++) {
      final res = checkResponses[i];
      if (res.isSuccess && res.successData != null) {
        final bool isInWishlist = res.successData['isInWishlist'] ?? false;
        if (isInWishlist) {
          updatedFavorites.add(products[i].id);
        } else {
          updatedFavorites.remove(products[i].id);
        }
      }
    }

    emit(state.copyWith(favoriteProductIds: updatedFavorites));
  }

  Future<void> getWishlist() async {
    emit(state.copyWith(wishlistState: DataState.loading));

    final response = await _homeRepository.getWishlist();
    if (response.isSuccess && response.successData != null) {
      List rawList = [];
      if (response.successData is Map) {
        final map = response.successData as Map;
        rawList = (map['list'] ?? map['data'] ?? map['items'] ?? []) as List;
      } else if (response.successData is List) {
        rawList = response.successData as List;
      }

      final List<WishlistItemModel> items = [];
      final updatedItemIds = Map<int, int>.from(state.wishlistItemIds);
      final updatedFavorites = Set<int>.from(state.favoriteProductIds);

      for (final item in rawList) {
        if (item is! Map<String, dynamic> && item is! Map) continue;
        final wishlistItem = WishlistItemModel.fromJson(
          Map<String, dynamic>.from(item as Map),
        );
        items.add(wishlistItem);
        if (wishlistItem.productId != 0 && wishlistItem.id != 0) {
          updatedItemIds[wishlistItem.productId] = wishlistItem.id;
          updatedFavorites.add(wishlistItem.productId);
        }
      }

      emit(
        state.copyWith(
          wishlistState: DataState.success,
          wishlistItems: items,
          wishlistItemIds: updatedItemIds,
          favoriteProductIds: updatedFavorites,
        ),
      );
    } else {
      emit(
        state.copyWith(
          wishlistState: DataState.failed,
          errorMessage: response.errorMsg ?? "حدث خطأ أثناء تحميل المفضلة",
        ),
      );
    }
  }

  Future<void> loadWishlistItemIds() async {
    await getWishlist();
  }

  Future<bool> checkProductInWishlist(int productId) async {
    final response = await _homeRepository.checkWishlist(productId);
    if (response.isSuccess && response.successData != null) {
      final bool isInWishlist = response.successData['isInWishlist'] ?? false;
      final updatedFavorites = Set<int>.from(state.favoriteProductIds);
      if (isInWishlist) {
        updatedFavorites.add(productId);
      } else {
        updatedFavorites.remove(productId);
      }
      emit(state.copyWith(favoriteProductIds: updatedFavorites));
      return isInWishlist;
    }
    return false;
  }

  Future<void> addToWishlist(int productId) async {
    emit(state.copyWith(addToWishlistState: DataState.loading));

    final response = await _homeRepository.addToWishlist(productId);

    if (response.isSuccess && response.successData != null) {
      final wishlistItem = WishlistItemModel.fromJson(response.successData);
      final updatedFavorites = Set<int>.from(state.favoriteProductIds)
        ..add(wishlistItem.productId);
      final updatedItemIds = Map<int, int>.from(state.wishlistItemIds)
        ..[wishlistItem.productId] = wishlistItem.id;
      final updatedWishlist = List<WishlistItemModel>.from(state.wishlistItems)
        ..removeWhere((item) => item.productId == wishlistItem.productId)
        ..insert(0, wishlistItem);

      emit(
        state.copyWith(
          addToWishlistState: DataState.success,
          addToWishlistMessage: "تمت إضافة المنتج إلى المفضلة",
          favoriteProductIds: updatedFavorites,
          wishlistItemIds: updatedItemIds,
          wishlistItems: updatedWishlist,
        ),
      );
    } else {
      emit(
        state.copyWith(
          addToWishlistState: DataState.failed,
          addToWishlistMessage:
              response.errorMsg ?? "حدث خطأ أثناء إضافة المنتج للمفضلة",
        ),
      );
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    emit(state.copyWith(removeFromWishlistState: DataState.loading));

    int? wishlistItemId = state.wishlistItemIds[productId];
    if (wishlistItemId == null) {
      await loadWishlistItemIds();
      wishlistItemId = state.wishlistItemIds[productId];
    }

    if (wishlistItemId == null) {
      emit(
        state.copyWith(
          removeFromWishlistState: DataState.failed,
          removeFromWishlistMessage: "تعذر العثور على المنتج في المفضلة",
        ),
      );
      return;
    }

    final response = await _homeRepository.removeFromWishlist(wishlistItemId);

    if (response.isSuccess) {
      final updatedFavorites = Set<int>.from(state.favoriteProductIds)
        ..remove(productId);
      final updatedItemIds = Map<int, int>.from(state.wishlistItemIds)
        ..remove(productId);
      final updatedWishlist = state.wishlistItems
          .where((item) => item.productId != productId)
          .toList();

      emit(
        state.copyWith(
          removeFromWishlistState: DataState.success,
          removeFromWishlistMessage: "تمت إزالة المنتج من المفضلة",
          favoriteProductIds: updatedFavorites,
          wishlistItemIds: updatedItemIds,
          wishlistItems: updatedWishlist,
        ),
      );
    } else {
      emit(
        state.copyWith(
          removeFromWishlistState: DataState.failed,
          removeFromWishlistMessage:
              response.errorMsg ?? "حدث خطأ أثناء إزالة المنتج من المفضلة",
        ),
      );
    }
  }

  Future<void> toggleWishlist(int productId) async {
    if (state.favoriteProductIds.contains(productId)) {
      await removeFromWishlist(productId);
    } else {
      await addToWishlist(productId);
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}