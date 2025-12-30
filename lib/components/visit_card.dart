// ignore_for_file: must_be_immutable

import 'dotted_line.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';

import 'common_text.dart';
import 'halfrounded_box.dart';

class VisitCard extends StatelessWidget {
  final String? statusText;
  final String? title;
  Color color;
  final String? date;
  final String? name;

  VisitCard({
    super.key,
    required this.title,
    this.statusText,
    required this.color,
    required this.date,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return HalfRounded(
      containerColor: Colors.white,
      isOutline: true,
      outlineColor: primaryAppColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: CommonText(
                    text: title.toString(),
                    color: Colors.blue,
                    weight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                      colors: [
                        color,
                        color.withOpacity(0.7),
                        color.withOpacity(0.5),
                      ],
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: CommonText(
                        text: statusText ?? "Undefined",
                        color: color,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Text(
              name.toString(),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            // Text(
            //   "Rs. $expenseList",
            //   style: TextStyle(color: Colors.grey.shade600),
            // ),
            SizedBox(height: 5),
            DottedLine(color: primaryAppColor),
            SizedBox(height: 5),
            CommonText(text: date.toString(), fontSize: 14.0),
          ],
        ),
      ),
    );
  }
}
