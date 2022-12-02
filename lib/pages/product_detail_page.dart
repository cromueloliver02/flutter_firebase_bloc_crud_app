import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/models.dart';
import 'pages.dart';

class ProductDetailPage extends StatefulWidget {
  static const id = '${HomePage.id}/detail';

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Product? product;

  @override
  void initState() {
    super.initState();
    _fetchProduct(widget.productId);
  }

  void _fetchProduct(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      product = Product.products.firstWhere((d) => d.id == widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        centerTitle: true,
        elevation: 0,
      ),
      body: product == null
          ? const _Spinner()
          : CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    CachedNetworkImage(
                      imageUrl: product!.imageUrl,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product!.name,
                            style: textTheme.headline5,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'x${product!.quantity} in stock',
                            style: textTheme.headline6!.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Php ${product!.price.toStringAsFixed(2)}',
                            style: textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product!.description,
                            style: textTheme.bodyText2,
                          ),
                          const SizedBox(height: 10),
                          ListTile(
                            title: Text(
                              'Recommended',
                              style: textTheme.subtitle1,
                            ),
                            trailing: product!.isRecommended
                                ? const Icon(
                                    Icons.check,
                                    size: 30,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.close,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                          ),
                          ListTile(
                            title: Text(
                              'Popular',
                              style: textTheme.subtitle1,
                            ),
                            trailing: product!.isPopular
                                ? const Icon(
                                    Icons.check,
                                    size: 30,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.close,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
    );
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
