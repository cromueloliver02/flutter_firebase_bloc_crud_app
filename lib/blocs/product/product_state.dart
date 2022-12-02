part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<Product> products;
  final ProductStatus status;
  final CustomError error;

  const ProductState({
    required this.products,
    required this.status,
    required this.error,
  });

  @override
  List<Object> get props => [products, status, error];

  factory ProductState.initial() {
    return ProductState(
      products: const <Product>[],
      status: ProductStatus.initial,
      error: CustomError(),
    );
  }

  @override
  String toString() =>
      'ProductState(products: $products, status: $status, error: $error)';

  ProductState copyWith({
    List<Product>? products,
    ProductStatus? status,
    CustomError? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
