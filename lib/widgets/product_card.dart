import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/models.dart';
import '../pages/pages.dart';
import '../utils/utils.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  void _goToProductDetailPage(BuildContext ctx) {
    Navigator.pushNamed(ctx, ProductDetailPage.id, arguments: product.id);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => _goToProductDetailPage(context),
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 1),
              blurRadius: 0.6,
            ),
          ],
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: product.imageUrl,
              width: 175,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.subtitle1,
                        ),
                        _ProductCardPopMenuButton(product: product),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      product.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: textTheme.bodyText1!.copyWith(color: Colors.grey),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Php ${product.price.toStringAsFixed(2)}',
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.subtitle1,
                        ),
                        Text(
                          'x ${product.quantity}',
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ProductCardPopMenuButton extends StatelessWidget {
  const _ProductCardPopMenuButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopMenuItemType>(
      onSelected: (value) {
        if (value == PopMenuItemType.edit) {
          goToProductFormPage(context, product);
        }

        if (value == PopMenuItemType.delete) {}
      },
      itemBuilder: (ctx) => [
        PopupMenuItem<PopMenuItemType>(
          value: PopMenuItemType.edit,
          child: Row(
            children: const [
              Icon(
                Icons.edit,
                color: Colors.blue,
              ),
              SizedBox(width: 10),
              Text('Edit'),
            ],
          ),
        ),
        PopupMenuItem<PopMenuItemType>(
          value: PopMenuItemType.delete,
          child: Row(
            children: const [
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text('Delete'),
            ],
          ),
        ),
      ],
    );
  }
}

enum PopMenuItemType { delete, edit }
