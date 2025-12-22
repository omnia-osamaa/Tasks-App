import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StateMemberWidget extends StatelessWidget {
  StateMemberWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });
  String title;
  String subTitle;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            subTitle,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xff5F33E1),
            ),
          ),
        ),
      ],
    );
  }
}
