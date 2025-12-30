import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'common_inkwell.dart';
import 'common_text.dart';

Future<dynamic> showBottomSheetList(
  BuildContext context,
  List<String> list,
  TextEditingController controller,
  final Function() onPress,
) {
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
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
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
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                    spreadRadius: 5,
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Wrap(
                    children: [
                      CommonInkwell(
                        onPress: () {
                          controller.text = list[index];
                          Navigator.pop(context);
                          onPress();
                        },
                        space: 15,
                        child: SizedBox(
                          width: w * 0.8,
                          child: CommonText(
                            text: list[index],
                            maxLines: 1,
                            overFlow: TextOverflow.ellipsis,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Divider(color: Colors.black12),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
