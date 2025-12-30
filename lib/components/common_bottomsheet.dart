import 'package:flutter/material.dart';

import '../utils/constants.dart';

Future<dynamic> showCommonBottomSheet(BuildContext context, {List<Widget>? children}) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  return showModalBottomSheet(
    context: context,
    backgroundColor: transparent,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(color: grey, borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 80,
              decoration: BoxDecoration(
                color: greyShade600,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: scaffoldBackground,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5),
                ],
              ),
              padding: EdgeInsets.all(10),
              child: Wrap(
                children: children ?? [],
              ),
            ),
          ],
        ),
      );
    },
  );
}
