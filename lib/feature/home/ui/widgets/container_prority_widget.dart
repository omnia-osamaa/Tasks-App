import 'package:flutter/material.dart';

class ContainerPriorityWidget extends StatelessWidget {
  const ContainerPriorityWidget({
    super.key,
    this.isSelected = false,
    required this.index,
    this.onTap,
  });
  final bool isSelected;
  final int index;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff5F33E1) : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: isSelected
              ? null
              : Border.all(color: Color(0xff6E6A7C), width: 1),
        ),
        child: Column(
          children: [
            ImageIcon(
              AssetImage("assets/icons/flag_icon.png"),
              color: isSelected ? Colors.white : Color(0xff5F33E1),
              size: 24,
            ),
            Text(
              "$index",
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Color(0xff24252C).withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
