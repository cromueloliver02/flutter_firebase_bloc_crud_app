import 'package:flutter/material.dart';

class FirebaseBlocCrudApp extends StatelessWidget {
  const FirebaseBlocCrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Bloc CRUD App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const Scaffold(
        body: Center(
          child: Text('Flutter Firebase Bloc CRUD App'),
        ),
      ),
    );
  }
}
