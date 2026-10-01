import '../../../core/enums/data_state.dart';
import '../models/product_model.dart';

class HomeState {
  final DataState productsState;
  final List<Data> products;
  final String? errorMessage;

  const HomeState({
    this.productsState = DataState.initial,
    this.products = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    DataState? productsState,
    List<Data>? products,
    String? errorMessage,
  }) {
    return HomeState(
      productsState: productsState ?? this.productsState,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}