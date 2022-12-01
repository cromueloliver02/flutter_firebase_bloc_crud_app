import 'package:flutter/material.dart';

import '../pages/pages.dart';

class RoutesHandler {
  final Map<String, WidgetBuilder> routes = {
    HomePage.id: (ctx) => const HomePage(),
  };
}
