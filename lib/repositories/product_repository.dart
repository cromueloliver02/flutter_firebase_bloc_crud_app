import 'package:image_picker/image_picker.dart';

import '../services/services.dart';
import '../models/models.dart';

class ProductRepository {
  final ProductService productService;

  ProductRepository({
    required this.productService,
  });

  Stream<List<Product>> get products {
    return productService.productSnapshots.map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromDoc(doc)).toList();
    });
  }

  Future<void> createProduct({
    required String name,
    required String description,
    required XFile image,
    required int quantity,
    required double price,
    required bool isPopular,
    required bool isRecommended,
    required DateTime dateCreated,
  }) async {
    try {
      await productService.createProduct(
        name: name,
        description: description,
        image: image,
        quantity: quantity,
        price: price,
        isPopular: isPopular,
        isRecommended: isRecommended,
        dateCreated: dateCreated,
      );
    } on CustomError {
      rethrow;
    }
  }

  Future<void> updateProduct(Product product, XFile? image) async {
    try {
      await productService.updateProduct(product, image);
    } on CustomError {
      rethrow;
    }
  }

  Future<void> deleteProduct(String productId, String imageUrl) async {
    try {
      await productService.deleteProduct(productId, imageUrl);
    } on CustomError {
      rethrow;
    }
  }
}
