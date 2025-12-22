import 'package:flutter/material.dart';

class MaterialButtonWidget extends StatelessWidget {
  const MaterialButtonWidget({
    super.key,
    required this.title,
    this.onPressed,
    this.colorBg,
    this.textColor,

  });
  final void Function()? onPressed;
  final String title;
  final Color? colorBg;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0,
      color:colorBg?? Color(0xff5F33E1),
      minWidth: double.infinity,
      height: 48,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color:textColor?? Colors.white,
        ),
      ),
    );
  }
}
