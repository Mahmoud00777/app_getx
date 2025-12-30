import 'package:flutter/material.dart';

import 'common_text.dart';

class PayrollText extends StatelessWidget {
  final String textLeft;
  final String textRight;
  final Color? color;
  const PayrollText({
    super.key,
    required this.textLeft,
    required this.textRight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(text: textLeft, fontSize: 16),
        Flexible(
          child: CommonText(
            textAlign: TextAlign.right,
            text: textRight,
            fontSize: 14,
            weight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
