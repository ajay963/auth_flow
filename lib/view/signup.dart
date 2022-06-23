import 'dart:io';
import 'dart:ui';
import 'package:auth_flow/services/firestore_services.dart';
import 'package:auth_flow/theme.dart';
import 'package:auth_flow/widgets/buttons.dart';
import 'package:auth_flow/widgets/custom_snakbars.dart';
import 'package:auth_flow/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../services/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? imageData;
  TextEditingController emailCtr = TextEditingController();
  TextEditingController nameCtr = TextEditingController();
  TextEditingController psdCtr = TextEditingController();
  TextEditingController cfrmPsdCtr = TextEditingController();
  TextEditingController phoneNoCtr = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _getImage() async {
      imageData = await _imagePicker.pickImage(source: ImageSource.gallery);
      int imageDataLength = await imageData!.length();
      if (imageDataLength > 10000) {
        showSnackBar(context: context, text: 'Image size exceeds');
      }
      setState(() {});
    }

    final authService = Provider.of<Authentication>(context);
    final firestoreServices = FirestoreServices();
    final TextTheme txtTheme = Theme.of(context).textTheme;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.06),
              if (imageData != null)
                Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        File(imageData!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              else
                const Center(
                  child: CircleAvatar(
                      radius: 50,
                      backgroundColor: kgreyShade1,
                      child: Icon(
                        LineIcons.user,
                        size: 50,
                        color: Colors.black,
                      )),
                ),
              SizedBox(height: height * 0.02),
              AddImageButton(onTap: () => _getImage()),
              SizedBox(height: height * 0.08),
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
