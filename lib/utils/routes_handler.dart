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
    }

    return null;
  }
}
