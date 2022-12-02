import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  late final StreamSubscription _productSubs;
  final ProductRepository productRepository;

  ProductBloc({
    required this.productRepository,
  }) : super(ProductState.initial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<UpdateProductsEvent>(_onUpdateProducts);
    on<CreateProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  @override
  Future<void> close() {
    _productSubs.cancel();
    return super.close();
  }

  void _onLoadProducts(LoadProductsEvent event, Emitter<ProductState> emit) {
    _productSubs = productRepository.products.listen((List<Product> products) {
      add(UpdateProductsEvent(products: products));
    });
  }

  void _onUpdateProducts(
    UpdateProductsEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(products: event.products));
  }

  void _onCreateProduct(
    CreateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.submitting));

    try {
      await productRepository.createProduct(
        name: event.name,
        description: event.description,
        image: event.image,
        quantity: event.quantity,
        price: event.price,
        isPopular: event.isPopular,
        isRecommended: event.isRecommended,
        dateCreated: event.dateCreated,
      );

      emit(state.copyWith(status: ProductStatus.success));
    } on CustomError catch (err) {
      emit(state.copyWith(
        status: ProductStatus.error,
        error: err,
      ));

      if (kDebugMode) print('state $state');
    }
  }

  void _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.submitting));

    try {
      await productRepository.updateProduct(event.product, event.image);

      emit(state.copyWith(status: ProductStatus.success));
    } on CustomError catch (err) {
      emit(state.copyWith(
        status: ProductStatus.error,
        error: err,
      ));

      if (kDebugMode) print('state $state');
    }
  }

  void _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await productRepository.deleteProduct(event.productId, event.imageUrl);
    } on CustomError catch (err) {
      emit(state.copyWith(
        status: ProductStatus.error,
        error: err,
      ));

      if (kDebugMode) print('state $state');
    }
  }
}

enum ProductStatus {
  initial,
  submitting,
  success,
  error,
}
