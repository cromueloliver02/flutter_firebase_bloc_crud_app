import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/models.dart';
import '../utils/utils.dart';

class ProductService {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  ProductService({
    required this.firestore,
    required this.storage,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> get productSnapshots {
    return firestore.collection(kUsersCollectionName).snapshots();
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
      await storage
          .ref('$kProductImagePath/${image.name}')
          .putFile(File(image.path));

      final imageUrl = await storage
          .ref('$kProductImagePath/${image.name}')
          .getDownloadURL();

      await firestore.collection(kUsersCollectionName).doc().set({
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'quantity': quantity,
        'price': price,
        'isPopular': isPopular,
        'isRecommended': isRecommended,
        'dateCreated': dateCreated.millisecondsSinceEpoch,
      });
    } on FirebaseException catch (err) {
      throw CustomError(
        code: err.code,
        message: err.message!,
        plugin: err.plugin,
      );
    } catch (err) {
      throw CustomError(
        code: 'Exception',
        message: err.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> updateProduct(Product product, XFile? image) async {
    try {
      String? imageUrl;

      if (image != null) {
        await storage
            .ref('$kProductImagePath/${image.name}')
            .putFile(File(image.path));

        imageUrl = await storage
            .ref('$kProductImagePath/${image.name}')
            .getDownloadURL();

        await storage.refFromURL(product.imageUrl).delete();
      }

      final newProduct = product.copyWith(
        imageUrl: imageUrl ?? product.imageUrl,
      );

      await firestore
          .collection(kUsersCollectionName)
          .doc(product.id)
          .update(newProduct.toMap());
    } on FirebaseException catch (err) {
      throw CustomError(
        code: err.code,
        message: err.message!,
        plugin: err.plugin,
      );
    } catch (err) {
      throw CustomError(
        code: 'Exception',
        message: err.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> deleteProduct(String productId, String imageUrl) async {
    try {
      await firestore.collection(kUsersCollectionName).doc(productId).delete();
      await storage.refFromURL(imageUrl).delete();
    } on FirebaseException catch (err) {
      throw CustomError(
        code: err.code,
        message: err.message!,
        plugin: err.plugin,
      );
    } catch (err) {
      throw CustomError(
        code: 'Exception',
        message: err.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }
}
