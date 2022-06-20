import 'package:auth_flow/model/user_model.dart';
import 'package:auth_flow/services/firestore_services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:auth_flow/widgets/buttons.dart';
import 'package:auth_flow/services/auth_services.dart';

class HomePage extends StatefulWidget {
  final String email;
  const HomePage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserData? _userData;
  @override
  void initState() {
    gettingUserInfo();
    super.initState();
  }

  void gettingUserInfo() async {
    _userData = await FirestoreServices().getUserInfo(email: widget.email);
  }

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
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Home Page',
              style: txtTheme.displayMedium,
            ),
            SizedBox(height: height * 0.04),
            Text(
              _userData?.email ?? 'data not available',
              style: txtTheme.bodyLarge,
            ),
            SizedBox(height: height * 0.04),
            Text(
              _userData?.phoneNo.toString() ?? 'data not available',
              style: txtTheme.bodyLarge,
            ),
            SizedBox(height: height * 0.04),
            Text(
              _userData?.name ?? 'data not available',
              style: txtTheme.bodyLarge,
            ),
            SizedBox(height: height * 0.2),
            Center(
              child: CircularButton(
                  icon: LineIcons.alternateSignOut,
                  radius: 50,
                  onTap: () => authService.signOut()),
            ),
            SizedBox(height: height * 0.04),
          ],
        ),
      ),
    ));
  }
}
