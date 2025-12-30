import "package:flutter/material.dart";
import "package:get/get.dart";

import "../utils/constants.dart";
import "common_text.dart";

class CommonLabel extends StatelessWidget {
  final String text;
  const CommonLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CommonText(
        text: text.tr,
        weight: FontWeight.w400,
        fontSize: 12,
        color: greyShade600);
  }
}

class CommonLabelReq extends StatelessWidget {
  final String text;
  const CommonLabelReq({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonText(
            text: text.tr,
            weight: FontWeight.w400,
            fontSize: 12,
            color: greyShade600),
        CommonText(
            text: " *",
            weight: FontWeight.w500,
            fontSize: 16,
            color: statusRed),
      ],
    );
  }
}
