// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../components/common_text.dart';
import '../../../utils/constants.dart';

class ColumnText extends StatelessWidget {
  String? title;
  String? text;
  double? width;
  MainAxisAlignment? mainAxisAlignment;
  CrossAxisAlignment? crossAxisAlignment;
  TextAlign? textAlign;
  int? maxLine;
  ColumnText({
    super.key,
    required this.title,
    required this.text,
    this.width,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.textAlign,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    // double _h = MediaQuery.of(context).size.height;
    return Visibility(
      visible: text != "",
      child: SizedBox(
        // color: red,
        width: width ?? w * 0.42,
        child: Column(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            CommonText(
              text: "$title".tr,
              color: grey,
              fontSize: 13,
              weight: FontWeight.w400,
              maxLines: 2,
            ),
            const SizedBox(height: 1),
            CommonText(
              text: text.toString(),
              weight: FontWeight.w500,
              fontSize: 14,
              textAlign: crossAxisAlignment == CrossAxisAlignment.end
                  ? TextAlign.right
                  : TextAlign.left,
              maxLines: maxLine ?? 3,
              overFlow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class RowText extends StatelessWidget {
  String type;
  String text;
  RowText({super.key, required this.type, required this.text});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: text != "",
      child: Row(
        children: [
          Expanded(
            child: CommonText(
              text: type.tr,
              color: grey,
              fontSize: 13,
              weight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: CommonText(
              text: text,
              weight: FontWeight.w600,
              fontSize: 14,
              maxLines: 2,
              textAlign: TextAlign.right,
              overFlow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
