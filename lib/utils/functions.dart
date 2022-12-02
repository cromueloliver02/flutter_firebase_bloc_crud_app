import 'package:flutter/material.dart';

import '../models/models.dart';
import '../pages/pages.dart';

void goToProductFormPage(BuildContext ctx, Product? product) {
  Navigator.pushNamed(ctx, CreateProductPage.id, arguments: product);
}
