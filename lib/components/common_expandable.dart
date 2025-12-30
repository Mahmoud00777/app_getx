// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";

import "../../../utils/constants.dart";

class CommonExpandible extends StatelessWidget {
  BuildContext nContext;
  bool? expanded;
  final List<Widget> widgets;
  final Widget title;
  final Widget? subTitle;
  final Color? collapsedColor;
  final Color? color;
  final Color? outlineColor;
  final double? radius;
  CommonExpandible({
    super.key,
    required this.nContext,
    required this.widgets,
    required this.title,
    this.color,
    this.collapsedColor,
    this.outlineColor,
    this.subTitle,
    this.expanded,
    this.radius,
  });

  @override
  Widget build(BuildContext nContext) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ExpansionTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        initiallyExpanded: expanded ?? false,
        title: title,
        collapsedBackgroundColor: collapsedColor ?? grey.withOpacity(0.2),
        backgroundColor: color,
        collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 20))),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: outlineColor ?? grey.withOpacity(0.2)),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 20))),
        subtitle: subTitle,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets,
            ),
          ),
        ],
      ),
    );
  }
}
