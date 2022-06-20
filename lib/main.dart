import 'package:auth_flow/model/user_model.dart';
import 'package:auth_flow/services/auth_services.dart';
import 'package:auth_flow/theme.dart';
import 'package:auth_flow/view/login.dart';
import 'package:auth_flow/view/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Authentication>(create: (context) => Authentication()),
      ],
      child: MaterialApp(
          theme: AppThemes.lightTheme,
          home: const Scaffold(
            body: LogInPage(),
          )),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<Authentication>(context);
    return StreamBuilder<UserData?>(
      stream: authService.user,
      builder: (context, AsyncSnapshot<UserData?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final UserData? user = snapshot.data;
          return (user == null) ? const LogInPage() : const SignUpPage();
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
