import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String text}) {
  final TextTheme txtTheme = Theme.of(context).textTheme;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: txtTheme.bodySmall,
      ),
    ),
  );
}
