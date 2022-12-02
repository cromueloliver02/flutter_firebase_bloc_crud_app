import 'package:flutter/material.dart';

import '../models/models.dart';
import '../pages/pages.dart';

class RoutesHandler {
  final Map<String, WidgetBuilder> routes = {
    HomePage.id: (ctx) => const HomePage(),
  };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CreateProductPage.id:
        final Product? product = settings.arguments as Product?;
        return MaterialPageRoute(
          settings: settings,
          builder: (ctx) => CreateProductPage(product: product),
        );

      case ProductDetailPage.id:
        final String productId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (ctx) => ProductDetailPage(productId: productId),
        );
    }

    return null;
  }
}
