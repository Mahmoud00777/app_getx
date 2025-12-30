import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../utils/constants.dart';
import '../utils/controllers/common_list_controller.dart';
import 'common_empty_data_widget.dart';
import 'common_inkwell.dart';
import 'common_text.dart';

Future<dynamic> filterBottomsheetAPI(
  BuildContext context,
  TextEditingController controller,
  String apiType,
  final Function() onPress,
  final Function() onReset,
) {
  final CommonListController commonListController = Get.put(
    CommonListController(),
  );
  commonListController.fetchList(apiType);
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
                  onPressed: onReset,
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
              child: Obx(() {
                if (commonListController.isLoading.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          height: 60,
                          width: 60,
                          'assets/animations/loading.json',
                          fit: BoxFit.contain,
                          frameRate: FrameRate(120),
                        ),
                        Text("loading".tr),
                      ],
                    ),
                  );
                } else {
                  var data = commonListController.commonListModel.value;
                  var list = data.data;

                  return list == null || list.isEmpty
                      ? ListView(
                          children: [SizedBox(height: 10), CommonEmptyData()],
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = list[index];

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonInkwell(
                                  onPress: () {
                                    controller.text = item.name ?? "---";
                                    Navigator.pop(context);
                                    onPress();
                                  },
                                  space: 15,
                                  child: SizedBox(
                                    width: w * 0.8,
                                    child: CommonText(
                                      text: item.name ?? "---",
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
                        );
                }
              }),
            ),
          ),
        ],
      );
    },
  );
}
