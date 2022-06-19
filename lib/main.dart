import 'package:auth_flow/theme.dart';
import 'package:auth_flow/view/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppThemes.lightTheme,
        home: const Scaffold(
          body: LogInPage(),
        ));
  }
}
