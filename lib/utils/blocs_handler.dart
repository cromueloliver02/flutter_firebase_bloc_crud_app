import 'package:cloud_firestore/cloud_firestore.dart';

import '../repositories/repositories.dart';
import '../blocs/blocs.dart';

class BlocsHandler {
  final List<RepositoryProvider> repositoryProviders = [
    RepositoryProvider<ProductRepository>(
      create: (ctx) => ProductRepository(
        firestore: FirebaseFirestore.instance,
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
