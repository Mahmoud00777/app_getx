// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_app/components/halfrounded_box.dart';
import 'package:pos_app/utils/constants.dart';

import '../utils/date_utils.dart';
import '../utils/time_utils.dart';
import 'common_text.dart';
import 'status_tag.dart';

class AttendanceCard extends StatelessWidget {
  String status;
  Color statusColor;
  String date;
  String checkinTime;
  String checkoutTime;

  AttendanceCard({
    super.key,
    required this.status,
    required this.statusColor,
    required this.date,
    required this.checkinTime,
    required this.checkoutTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: HalfRounded(
        containerColor: white,
        isOutline: false,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonText(
                    text: formatDateMMdd(date),
                    color: secondaryAppColor,
                    weight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  StatusTag(status: status, statusColor: statusColor),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CommonText(text: "checkin".tr),
                      checkinTime == ""
                          ? CommonText(text: "--:--", weight: FontWeight.w500)
                          : CommonText(
                              text: extractAndFormatTime(checkinTime),
                              weight: FontWeight.w500,
                            ),
                    ],
                  ),
                  SizedBox(height: 45, child: VerticalDivider(color: grey)),
                  Column(
                    children: [
                      CommonText(text: "checkout".tr),
                      checkoutTime == ""
                          ? CommonText(text: "--:--", weight: FontWeight.w500)
                          : CommonText(
                              text: extractAndFormatTime(checkoutTime),
                              weight: FontWeight.w500,
                            ),
                    ],
                  ),
                  SizedBox(height: 45, child: VerticalDivider(color: grey)),
                  Column(
                    children: [
                      CommonText(text: "duration".tr),
                      CommonText(
                        text: checkinTime.isNotEmpty && checkoutTime.isNotEmpty
                            ? calculateWorkDuration(checkinTime, checkoutTime)
                            : "--:--",
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
  //------------- Custom Functions
  //

  //------------- Calculate work duration. starttime "2024-12-24 09:15:10"
  String calculateWorkDuration(String startTimeString, String endTimeString) {
    DateTime startTime = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).parse(startTimeString);
    DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(endTimeString);

    // Calculate the duration
    Duration duration = endTime.difference(startTime);

    // Get hours and minutes
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;

    // Format the result based on conditions
    if (hours > 0 && minutes > 0) {
      // Case with both hours and minutes
      String hourLabel = hours == 1 ? 'hr' : 'hrs';
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $hourLabel';
    } else if (hours > 0) {
      // Case with only hours
      String hourLabel = hours == 1 ? 'hr' : 'hrs';
      return '${hours.toString().padLeft(2, '0')}:00 $hourLabel';
    } else {
      // Case with only minutes
      String minuteLabel = minutes == 1 ? 'min' : 'mins';
      return '00:${minutes.toString().padLeft(2, '0')} $minuteLabel';
    }
  }
}
