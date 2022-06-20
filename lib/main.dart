import 'package:auth_flow/services/auth_services.dart';
import 'package:auth_flow/theme.dart';
import 'package:auth_flow/view/home.dart';
import 'package:auth_flow/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        Provider<Authentication>(
          create: (context) => Authentication(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<Authentication>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
          theme: AppThemes.lightTheme,
          home: const Scaffold(
            body: AuthWrapper(),
          )),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return HomePage(
        email: firebaseUser.email ?? 'Email Not Available',
      );
    }
    return const LogInPage();
  }
}
