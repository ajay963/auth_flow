import 'package:auth_flow/model/user_model.dart';
import 'package:auth_flow/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:auth_flow/widgets/buttons.dart';
import 'package:auth_flow/services/auth_services.dart';

class HomePage extends StatelessWidget {
  final String email;
  const HomePage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserData initialUserData = UserData(
        name: 'fetching name',
        uid: 'fetching uid',
        email: 'fetching email',
        imageUrl: 'fetching url',
        phoneNo: 9988779900);
    Future<UserData?> userData = FirestoreServices().getUserInfo(email: email);
    final TextTheme txtTheme = Theme.of(context).textTheme;
    final double height = MediaQuery.of(context).size.height;
    final authService = Provider.of<Authentication>(context);

    return SafeArea(
        child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
          height: height,
          child: FutureBuilder<UserData?>(
            initialData: initialUserData,
            future: userData,
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Home Page',
                    style: txtTheme.displayMedium,
                  ),
                  SizedBox(height: height * 0.04),
                  Text(
                    snapshot.data!.email,
                    style: txtTheme.bodyLarge,
                  ),
                  SizedBox(height: height * 0.04),
                  Text(
                    snapshot.data!.phoneNo.toString(),
                    style: txtTheme.bodyLarge,
                  ),
                  SizedBox(height: height * 0.04),
                  Text(
                    snapshot.data!.name,
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
              );
            },
          )),
    ));
  }
}
