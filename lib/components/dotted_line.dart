// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utils/constants.dart';

// ignore: camel_case_types
class DottedLine extends StatelessWidget {
  Color? color;
  DottedLine({
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < 50; i++)
          Container(
            width: 5,
            height: 1,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: i % 2 == 0 ? color ?? black : Colors.transparent,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
