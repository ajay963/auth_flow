import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String imageURL;
  final String name;
  final String email;
  const HomePage(
      {Key? key,
      required this.name,
      required this.email,
      required this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageURL),
          ),
          Text(name),
          Text(email),
        ],
      ),
    );
  }
}
