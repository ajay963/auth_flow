import 'package:auth_flow/services/firestore_services.dart';
import 'package:auth_flow/widgets/buttons.dart';
import 'package:auth_flow/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailCtr = TextEditingController();
  TextEditingController nameCtr = TextEditingController();
  TextEditingController psdCtr = TextEditingController();
  TextEditingController cfrmPsdCtr = TextEditingController();
  TextEditingController phoneNoCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<Authentication>(context);
    final firestoreServices = FirestoreServices();
    final TextTheme txtTheme = Theme.of(context).textTheme;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('  Sign Up', style: txtTheme.displayMedium),
              SizedBox(height: height * 0.02),
              EmailField(controller: emailCtr),
              SizedBox(height: height * 0.02),
              KTextField(
                  label: 'USER NAME',
                  hideText: false,
                  iconData: LineIcons.user,
                  controller: nameCtr),
              SizedBox(height: height * 0.04),
              KTextField(
                  label: 'PHONE NO',
                  hideText: false,
                  iconData: LineIcons.phone,
                  controller: phoneNoCtr),
              SizedBox(height: height * 0.04),
              KTextField(
                  label: 'PASSWORD',
                  hideText: true,
                  iconData: LineIcons.lock,
                  controller: psdCtr),
              SizedBox(height: height * 0.04),
              KTextField(
                  label: 'CONFIRM PASSWORD',
                  hideText: true,
                  iconData: LineIcons.lock,
                  controller: cfrmPsdCtr),
              SizedBox(height: height * 0.04),
              Center(child: Text('OR', style: txtTheme.bodySmall)),
              SizedBox(height: height * 0.04),
              KFlatButton(
                  label: 'google sign in',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please Enter your Email Id')));
                  }),
              SizedBox(height: height * 0.1),
              Center(
                  child: CircularButton(
                      onTap: () {
                        if (emailCtr.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please Enter your Email Id')));
                        } else if (nameCtr.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please Enter your Name')));
                        } else if (psdCtr.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please Enter your Password')));
                        } else if (psdCtr.text != cfrmPsdCtr.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Password are not Matching')));
                        } else {
                          authService.signUp(
                              email: emailCtr.text.trim(),
                              password: psdCtr.text.trim(),
                              context: context);
                          firestoreServices.addUserInfo(
                              uid: '',
                              imageUrl: '',
                              email: emailCtr.text.trim(),
                              name: nameCtr.text.trim(),
                              phoneNo: int.parse(phoneNoCtr.text));
                          Navigator.pop(context);
                        }
                      },
                      icon: LineIcons.arrowRight,
                      radius: 50)),
              SizedBox(height: height * 0.04)
            ],
          ),
        ),
      ),
    );
  }
}
