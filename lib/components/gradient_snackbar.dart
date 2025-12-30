import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import '../utils/html_parse.dart';
import 'common_text.dart';

GetSnackBar gradientSnackbar(tText, sText, sColor, sIcon) {
  return GetSnackBar(
    barBlur: 3.0,

    titleText: Directionality(
        textDirection: TextDirection.ltr,
        child: CommonText(text: tText, maxLines: 1, overFlow: TextOverflow.ellipsis, color: white, weight: FontWeight.w500, lineHeight: 0)),
    messageText: Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        constraints: BoxConstraints(maxHeight: 120),
        child: SingleChildScrollView(
          // reverse: true,
          child: CommonText(
            text: parseHtml(sText),
            // maxLines: 3,
            // overFlow: TextOverflow.ellipsis,
            color: white,
            weight: FontWeight.w400,
            fontSize: 12,
            lineHeight: 0,
          ),
        ),
      ),
    ),

    // title: tText,
    // message: (sText),
    borderColor: sColor,
    borderWidth: 1,
    snackStyle: SnackStyle.FLOATING,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    // margin: EdgeInsets.all(20),
    backgroundGradient: LinearGradient(colors: [sColor, sColor.withOpacity(0.5)]),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    icon: Icon(sIcon, color: Colors.white, size: 32),
    borderRadius: 0,
    duration: Duration(seconds: 3),
    // backgroundColor: sColor,
  );
}
