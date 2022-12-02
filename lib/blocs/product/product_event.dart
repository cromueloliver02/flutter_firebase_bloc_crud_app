part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductEvent {}

class UpdateProductsEvent extends ProductEvent {
  final List<Product> products;

  const UpdateProductsEvent({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}

class CreateProductEvent extends ProductEvent {
  final String name;
  final String description;
  final XFile image;
  final int quantity;
  final double price;
  final bool isPopular;
  final bool isRecommended;
  final DateTime dateCreated;

  const CreateProductEvent({
    required this.name,
    required this.description,
    required this.image,
    required this.quantity,
    required this.price,
    required this.isPopular,
    required this.isRecommended,
    required this.dateCreated,
  });

  @override
  List<Object> get props => [
        name,
        description,
        image,
        quantity,
        price,
        isPopular,
        isRecommended,
        dateCreated,
      ];
}

class UpdateProductEvent extends ProductEvent {
  final Product product;
  final XFile? image;

  const UpdateProductEvent({
    required this.product,
    required this.image,
  });

  @override
  List<Object?> get props => [product, image];
}
