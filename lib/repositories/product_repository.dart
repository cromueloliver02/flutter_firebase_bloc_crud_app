import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';
import '../utils/constants.dart';

class ProductRepository {
  final FirebaseFirestore firestore;

  ProductRepository({
    required this.firestore,
  });

  Stream<List<Product>> get products =>
      firestore.collection(kUsersCollectionName).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());

  // Stream<List<Product>> loadProducts() {
  //   return firestore.collection(kUsersCollectionName).snapshots().map(
  //       (snapshot) =>
  //           snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());
  // }
}
