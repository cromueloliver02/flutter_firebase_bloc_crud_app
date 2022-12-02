import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';
import '../utils/utils.dart';

class HomePage extends StatelessWidget {
  static const id = '/home';

  const HomePage({super.key});

  ProductCard _buildProductCard(BuildContext ctx, int idx) {
    final product = Product.products[idx];

    return ProductCard(product: product);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => goToProductFormPage(context, null),
            iconSize: 30,
            icon: const Icon(Icons.add_circle),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Products',
                style: textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: Product.products.length,
                _buildProductCard,
              ),
            ),
          )
        ],
      ),
    );
  }
}
