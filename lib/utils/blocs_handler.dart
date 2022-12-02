import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../services/services.dart';
import '../repositories/repositories.dart';
import '../blocs/blocs.dart';

class BlocsHandler {
  final List<RepositoryProvider> repositoryProviders = [
    RepositoryProvider<ProductRepository>(
      create: (ctx) => ProductRepository(
        productService: ProductService(
          firestore: FirebaseFirestore.instance,
          storage: FirebaseStorage.instance,
        ),
      ),
    ),
  ];

  final List<BlocProvider> blocProviders = [
    BlocProvider<ProductBloc>(
      create: (ctx) => ProductBloc(
        productRepository: ctx.read<ProductRepository>(),
      )..add(LoadProductsEvent()),
    ),
  ];
}
