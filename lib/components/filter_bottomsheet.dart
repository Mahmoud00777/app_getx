import "package:flutter/material.dart";
import "package:get/get.dart";

import "../utils/constants.dart";
import "common_inkwell.dart";
import "common_text.dart";

// Modal bottom sheet of Filters
Future<dynamic> showFilterBottomSheet(
  BuildContext context,
  List<String> list,
  TextEditingController controller,
  final Function() onPress,
  final Function() onReset,
) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  return showModalBottomSheet(
    backgroundColor: Colors.grey.shade200,
    // showDragHandle: true,
    context: context,
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(flex: 2),
                Container(
                  height: 6,
                  width: 50,
                  decoration: BoxDecoration(
                    color: black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onReset();
                  },
                  child: CommonText(text: "reset".tr),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonInkwell(
                        onPress: () {
                          controller.text = list[index];
                          Navigator.pop(context);
                          onPress();
                        },
                        space: 10,
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
                      Divider(color: Colors.black12),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      );
    },
  );
}
