import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/constants.dart';

class CustomToast {
  static void showToast({
    required String msg,
    Color? backgroundColor,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor,
      textColor: white,
      fontSize: 16.0,
    );
  }
}
