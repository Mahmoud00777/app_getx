import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../utils/constants.dart';
import '../utils/controllers/common_list_controller.dart';
import 'common_empty_data_widget.dart';
import 'common_inkwell.dart';
import 'common_search_field.dart';
import 'common_text.dart';

Future<dynamic> showBottomSheetListAPI(
  BuildContext context,
  TextEditingController controller,
  TextEditingController searchController,
  String apiType,
  bool isSearch,
  final Function() onSearch,
  final Function() onPress,
) {
  final CommonListController commonListController = Get.put(
    CommonListController(),
  );
  commonListController.fetchList(apiType);
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
              // padding: EdgeInsets.all(10),
              child: Wrap(
                children: <Widget>[
                  Column(
                    children: [
                      isSearch
                          ? Column(
                              children: [
                                SizedBox(height: 5),
                                SearchBox(
                                  searchController: searchController,
                                  hint: apiType,
                                  onSub: (value) {
                                    onSearch();
                                  },
                                ),
                                SizedBox(height: 10),
                              ],
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 350,
                        child: Obx(() {
                          if (commonListController.isLoading.value) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    height: 120,
                                    width: 120,
                                    'assets/animations/loading.json',
                                    fit: BoxFit.contain,
                                    frameRate: FrameRate(120),
                                  ),
                                  Text("loading".tr),
                                ],
                              ),
                            );
                          } else {
                            var data =
                                commonListController.commonListModel.value;
                            var list = data.data;

                            return list == null || list.isEmpty
                                ? ListView(
                                    children: [
                                      SizedBox(height: 10),
                                      CommonEmptyData(),
                                    ],
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.all(10),
                                    itemCount: list.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                          var item = list[index];
                                          if (isSearch == true) {
                                            if (searchController
                                                    .text
                                                    .isNotEmpty &&
                                                !item.name
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains(
                                                      searchController.text
                                                          .toLowerCase(),
                                                    )) {
                                              return SizedBox.shrink();
                                            }
                                          }

                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CommonInkwell(
                                                onPress: () {
                                                  controller.text =
                                                      item.name ?? "---";
                                                  Navigator.pop(context);
                                                  onPress;
                                                },
                                                space: 15,
                                                child: SizedBox(
                                                  width: w * 0.8,
                                                  child: CommonText(
                                                    text: item.name ?? "---",
                                                    maxLines: 1,
                                                    overFlow:
                                                        TextOverflow.ellipsis,
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
