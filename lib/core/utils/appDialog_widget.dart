import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/material_button_widget.dart';

abstract class AppDialog {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
            content: Row(
          spacing: 15,
          children: [
            CircularProgressIndicator(color: Color(0xff5F33E1)),
            SizedBox(width: 20),
            Text(
              "Loading...",
              style: TextStyle(fontSize: 20),
            ),
          ],
        )),
      ),
    );
  }

  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            )),
        content: Text(
          message,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          MaterialButtonWidget(
            title: "Close",
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  static void showDialogLoading(BuildContext context) {}

  static void showDialogError(BuildContext context, error) {}
}
