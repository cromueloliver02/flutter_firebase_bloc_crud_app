import 'package:flutter/material.dart';

import './pages/pages.dart';
import './utils/utils.dart';

class FirebaseBlocCrudApp extends StatelessWidget {
  FirebaseBlocCrudApp({super.key});

  final _routesHandler = RoutesHandler();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Bloc CRUD App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const HomePage(),
      routes: _routesHandler.routes,
    );
  }
}
