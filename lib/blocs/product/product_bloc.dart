import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

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
}
