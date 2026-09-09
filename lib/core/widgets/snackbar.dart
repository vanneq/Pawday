import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSuccessSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 220,
        left: 16,
        right: 16,
      ),
      backgroundColor: Colors.green.shade300,
      duration: Duration(seconds: 3),
      content: Row(
        children: [
          Icon(CupertinoIcons.checkmark_circle, color: Colors.white),
          SizedBox(width: 8),
          Text(text),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}

void showErrorSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 220,
        left: 16,
        right: 16,
      ),
      backgroundColor: Colors.red.shade200,
      duration: Duration(seconds: 3),
      content: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.white),
          SizedBox(width: 8),
          Expanded(child: Text(text, maxLines: 3, softWrap: true)),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
