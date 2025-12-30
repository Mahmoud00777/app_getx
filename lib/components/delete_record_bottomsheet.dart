// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import '../utils/controllers/delete_record_controller.dart';
import 'common_inkwell.dart';
import 'common_text.dart';

Future<dynamic> DeleteRecordBottomsheet(
  BuildContext context, {
  String? id,
  String? docType,
  required Function() onPressed,
}) {
  final DeleteRecordController controller = Get.put(DeleteRecordController());

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
                )),
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
                children: <Widget>[
                  Column(
                    children: [
                      // Visibility(
                      //   visible: status == "Draft",
                      //   child: RowIconText(
                      //       text: "Submit",
                      //       icon: Icons.send_time_extension_outlined,
                      //       onPressed: () {
                      //         controller.updateStatus(action: "Submit", docType: docType, id: id, onPressed: onPressed);
                      //       }),
                      // ),
                      // Visibility(
                      //   visible: status != "Cancelled",
                      //   child: RowIconText(
                      //       text: "cancel",
                      //       icon: Icons.disabled_by_default_outlined,
                      //       onPressed: () {
                      //         controller.updateStatus(action: "Cancel", docType: docType, id: id, onPressed: onPressed);
                      //       }),
                      // ),
                      RowIconText(
                          text: "delete",
                          icon: Icons.delete_outline_rounded,
                          color: statusRed,
                          onPressed: () {
                            controller.deleteRecord(docType: docType, id: id, onPressed: onPressed);
                          }),
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

class RowIconText extends StatelessWidget {
  String text;
  IconData icon;
  Color? color;
  Function() onPressed;
  RowIconText({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onPress: () {
        Get.back();
        onPressed();
      },
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: color?.withOpacity(0.1) ?? white, borderRadius: BorderRadius.circular(15)),
              child: Icon(icon, color: color ?? grey)),
          const SizedBox(width: 10),
          CommonText(text: text.tr, weight: FontWeight.w500, fontSize: 15)
        ],
      ),
    );
  }
}
