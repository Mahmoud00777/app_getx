import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../components/common_text.dart";
import "../../../utils/constants.dart";

// Modal bottom sheet of Report
Future<dynamic> showReportBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.grey.shade200,
    // showDragHandle: true,
    context: context,
    builder: (context) {
      return SizedBox(
        height: 150,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 70,
                    decoration: BoxDecoration(
                      color: black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: CommonText(
                text: "     Report an issue via:",
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    _launchMail();
                    Get.back();
                  },
                  child: Column(
                    children: [
                      Image(
                        height: 40,
                        width: 40,
                        image: AssetImage("assets/icons/mail.png"),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      CommonText(
                        text: "Email",
                        fontSize: 16,
                        weight: FontWeight.w400,
                        color: grey,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchWhatsApp("+923351206668");
                    Get.back();
                  },
                  child: Column(
                    children: [
                      Image(
                        height: 40,
                        width: 40,
                        image: AssetImage("assets/icons/whatsapp.png"),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      CommonText(
                        text: "WhatsApp",
                        fontSize: 16,
                        weight: FontWeight.w400,
                        color: grey,
                      ),
                    ],
                  ),
                ),
                // InkWell(
                //   onTap: () {

                //     Get.back();
                //         Get.to(()=>InfoScreen());
                //   },
                //   child: Column(
                //     children: [
                //       Image(
                //           height: 40,
                //           width: 40,
                //           image: AssetImage("assets/icons/info.png"),
                //           fit: BoxFit.cover),
                //       SizedBox(height: 8),
                //       CommonText(
                //           text: "Info",
                //           fontSize: 16,
                //           weight: FontWeight.w400,
                //           color: grey)
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

//------- Launch Mail
void _launchMail() async {
  String subject = 'ERPNext Employee HUB';
  String encodedSubject = subject.replaceAll(' ', '%20');
  String body =
      'Hello Codes Soft 👋🏻, I am contacting you through the ERPNext Employee HUB and am experiencing some issues with it ⚠️';
  String encodedbody = body.replaceAll(' ', '%20');

  String url =
      'mailto:info@codessoft.com?subject=$encodedSubject&body=$encodedbody';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//------- Launch WhatsApp
void _launchWhatsApp(String phone) async {
  const message =
      'Hello Codes Soft 👋🏻, I am contacting you through the ERPNext Employee HUB and am experiencing some issues with it ⚠️';
  final encodedMessage = Uri.encodeComponent(message);
  String url = 'https://wa.me/$phone?text=$encodedMessage';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
