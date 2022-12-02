part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<Product> products;

  const ProductState({
    required this.products,
  });

  @override
  List<Object> get props => [products];

  factory ProductState.initial() {
    return const ProductState(products: <Product>[]);
  }

  @override
  String toString() => 'ProductState(products: $products)';

  ProductState copyWith({
    List<Product>? products,
  }) {
    return ProductState(
      products: products ?? this.products,
    );
  }
}
