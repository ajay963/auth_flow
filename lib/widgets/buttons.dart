import 'package:auth_flow/theme.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CircularButton extends StatelessWidget {
  final IconData icon;
  final double radius;
  final Function() onTap;
  const CircularButton(
      {Key? key, required this.icon, required this.radius, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color? iconColor = Theme.of(context).iconTheme.color;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Ink(
        height: radius,
        width: radius,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: [kshade1, kshade2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Center(
            child: Icon(
          icon,
          color: iconColor ?? const Color(0xffFFFFFF),
        )),
      ),
    );
  }
}

class KFlatButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  const KFlatButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme txtTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: kshade1, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            label,
            style: txtTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}

class AddImageButton extends StatelessWidget {
  final Function() onTap;
  const AddImageButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme txtTheme = Theme.of(context).textTheme;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Add Image', style: txtTheme.bodySmall),
          const SizedBox(width: 20),
          CircularButton(icon: LineIcons.plus, radius: 30, onTap: onTap)
        ],
      ),
    );
  }
}
