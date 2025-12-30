// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pos_app/utils/constants.dart';
import 'dotted_line.dart';
import 'common_text.dart';
import 'halfrounded_box.dart';

class ExpenseCard extends StatelessWidget {
  final String statusText;
  final double priceList;
  final String date;
  final String expenseText;
  final String description;
  // final String expenseList;
  Color color;

  ExpenseCard({
    super.key,
    required this.statusText,
    required this.priceList,
    required this.date,
    required this.expenseText,
    required this.description,
    // required this.expenseList,
    required this.color,
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
                    text: expenseText.toString(),
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
                        text: statusText,
                        color: color,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            CommonText(
              text: "\$ $priceList",
              fontSize: 18.0,
              weight: FontWeight.bold,
            ),

            SizedBox(height: 5),
            CommonText(
              text: description,
              fontSize: 16.0,
              weight: FontWeight.w300,
            ),

            // Text(
            //   "Rs. $expenseList",
            //   style: TextStyle(color: Colors.grey.shade600),
            // ),
            SizedBox(height: 5),
            DottedLine(color: primaryAppColor),
            SizedBox(height: 5),
            CommonText(text: date, fontSize: 14.0),
          ],
        ),
      ),
    );
  }
}
