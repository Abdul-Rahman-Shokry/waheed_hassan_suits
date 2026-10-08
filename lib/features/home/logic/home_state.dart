import '../../../core/enums/data_state.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class HomeState {
  final String? searchQuery;
  final DataState productsState;
  final List<Data> products;
  final String? errorMessage;
  final DataState categoriesState;
  final List<CategoryModel> categories;
  final int? selectedCategoryId;
  final double? minPrice;
  final double? maxPrice;
  final DataState addToWishlistState;
  final String? addToWishlistMessage;
  final DataState removeFromWishlistState;
  final String? removeFromWishlistMessage;
  final Set<int> favoriteProductIds;
  final Map<int, int> wishlistItemIds;

  const HomeState({
    this.searchQuery,
    this.productsState = DataState.initial,
    this.products = const [],
    this.errorMessage,
    this.categoriesState = DataState.initial,
    this.categories = const [],
    this.selectedCategoryId,
    this.minPrice,
    this.maxPrice,
    this.addToWishlistState = DataState.initial,
    this.addToWishlistMessage,
    this.removeFromWishlistState = DataState.initial,
    this.removeFromWishlistMessage,
    this.favoriteProductIds = const {},
    this.wishlistItemIds = const {},
  });

  HomeState copyWith({
    String? searchQuery,
    bool clearSearch = false,
    DataState? productsState,
    List<Data>? products,
    String? errorMessage,
    DataState? categoriesState,
    List<CategoryModel>? categories,
    int? selectedCategoryId,
    bool clearSelectedCategory = false,
    double? minPrice,
    double? maxPrice,
    bool clearPriceFilter = false,
    DataState? addToWishlistState,
    String? addToWishlistMessage,
    DataState? removeFromWishlistState,
    String? removeFromWishlistMessage,
    Set<int>? favoriteProductIds,
    Map<int, int>? wishlistItemIds,
  }) {
    return HomeState(
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
      productsState: productsState ?? this.productsState,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      categoriesState: categoriesState ?? this.categoriesState,
      categories: categories ?? this.categories,
      selectedCategoryId: clearSelectedCategory
          ? null
          : (selectedCategoryId ?? this.selectedCategoryId),
      minPrice: clearPriceFilter ? null : (minPrice ?? this.minPrice),
      maxPrice: clearPriceFilter ? null : (maxPrice ?? this.maxPrice),
      addToWishlistState: addToWishlistState ?? this.addToWishlistState,
      addToWishlistMessage: addToWishlistMessage ?? this.addToWishlistMessage,
      removeFromWishlistState:
          removeFromWishlistState ?? this.removeFromWishlistState,
      removeFromWishlistMessage:
          removeFromWishlistMessage ?? this.removeFromWishlistMessage,
      favoriteProductIds: favoriteProductIds ?? this.favoriteProductIds,
      wishlistItemIds: wishlistItemIds ?? this.wishlistItemIds,
    );
  }
}