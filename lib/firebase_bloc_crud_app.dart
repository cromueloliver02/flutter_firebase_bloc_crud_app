import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './pages/pages.dart';
import './utils/utils.dart';

class FirebaseBlocCrudApp extends StatelessWidget {
  FirebaseBlocCrudApp({super.key});

  final _blocsHandler = BlocsHandler();
  final _routesHandler = RoutesHandler();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: _blocsHandler.repositoryProviders,
      child: MultiBlocProvider(
        providers: _blocsHandler.blocProviders,
        child: MaterialApp(
          title: 'Flutter Firebase Bloc CRUD App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          home: const HomePage(),
          routes: _routesHandler.routes,
          onGenerateRoute: _routesHandler.onGenerateRoute,
        ),
      ),
    );
  }
}
