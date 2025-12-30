// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";

import "../utils/constants.dart";
import "common_text.dart";

class StatusTag extends StatelessWidget {
  String status;
  Color statusColor;
  StatusTag({
    super.key,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: status != "",
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: statusColor.withOpacity(0.15),
          // gradient: LinearGradient(
          //   colors: [
          //     statusColor,
          //     statusColor.withOpacity(0.5),
          //     statusColor.withOpacity(0.2)
          //   ],
          // ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: CommonText(text: status, color: statusColor, fontSize: 10, weight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
