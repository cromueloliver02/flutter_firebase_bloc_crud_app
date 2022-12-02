import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../models/models.dart';
import '../pages/pages.dart';

void goToProductFormPage(BuildContext ctx, Product? product) {
  Navigator.pushNamed(ctx, CreateProductPage.id, arguments: product);
}

void showErrorDialog(BuildContext ctx, CustomError error) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: ctx,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(error.code),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(error.plugin),
            Text(error.message),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  if (Platform.isAndroid) {
    showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: Text(error.code),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(error.plugin),
            Text(error.message),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
