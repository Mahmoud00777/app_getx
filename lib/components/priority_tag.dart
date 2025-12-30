// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";

import "common_text.dart";

class PriorityTag extends StatelessWidget {
  String priority;
  Color priorityColor;
  PriorityTag({super.key, required this.priority, required this.priorityColor});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: priority != "",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: priorityColor,
            ),
          ),
          CommonText(
            text: " $priority ",
            color: priorityColor.withOpacity(0.8),
            fontSize: 10,
            weight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
