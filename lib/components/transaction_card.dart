// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dotted_line.dart';
import '../utils/constants.dart';
import 'common_text.dart';
import 'halfrounded_box.dart';

class TransactionCard extends StatelessWidget {
  final String statusText;
  final Color? balanceColor;
  final String? date;
  final double? debit;
  final double? credit;
  final double? balance;
  Color color;

  TransactionCard({
    super.key,
    required this.statusText,
    this.balanceColor,
    this.date,
    this.debit,
    this.credit,
    this.balance,
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
              children: [
                Text(
                  date!,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
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
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.0,
                        vertical: 6.0,
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
            DottedLine(color: primaryAppColor),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('debit'.tr, style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 5),
                    Text(
                      debit!.toStringAsFixed(2),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('credit'.tr, style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 5),
                    Text(
                      credit!.toStringAsFixed(2),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('balance'.tr, style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 5),
                    CommonText(
                      text: balance!.toStringAsFixed(2),
                      color: balanceColor,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
