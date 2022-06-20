import 'package:auth_flow/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';

class HomePage extends StatelessWidget {
  final String email;
  const HomePage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme txtTheme = Theme.of(context).textTheme;
    final double height = MediaQuery.of(context).size.height;
    final authService = Provider.of<Authentication>(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Home Page',
                style: txtTheme.displayMedium,
              ),
              Text(
                'email: $email',
                style: txtTheme.bodyLarge,
              ),
              Center(
                child: CircularButton(
                    icon: LineIcons.alternateSignOut,
                    radius: 50,
                    onTap: () => authService.signOut()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
