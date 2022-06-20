import 'package:auth_flow/services/auth_services.dart';
import 'package:auth_flow/view/signup.dart';
import 'package:auth_flow/widgets/buttons.dart';
import 'package:auth_flow/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<Authentication>(context);
    final TextTheme txtTheme = Theme.of(context).textTheme;
    final double height = MediaQuery.of(context).size.height;
    TextEditingController emailCtr = TextEditingController();
    TextEditingController psdCtr = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('  Log In', style: txtTheme.displayMedium),
            SizedBox(height: height * 0.02),
            EmailField(controller: emailCtr),
            SizedBox(height: height * 0.02),
            KTextField(
                label: 'PASSWORD',
                hideText: true,
                iconData: LineIcons.user,
                controller: psdCtr),
            SizedBox(height: height * 0.04),
            Center(child: Text('OR', style: txtTheme.bodySmall)),
            SizedBox(height: height * 0.04),
            KFlatButton(
              label: 'create account',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUpPage())),
            ),
            SizedBox(height: height * 0.04),
            KFlatButton(label: 'google sign in', onTap: () {}),
            SizedBox(height: height * 0.1),
            Center(
                child: CircularButton(
                    onTap: () {
                      if (emailCtr.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter your Email Id')));
                      } else if (psdCtr.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Password')));
                      } else {
                        authService.signIn(
                            email: emailCtr.text.trim(),
                            password: psdCtr.text.trim());
                      }
                    },
                    icon: LineIcons.arrowRight,
                    radius: 50)),
            SizedBox(height: height * 0.04)
          ],
        ),
      ),
    );
  }
}
