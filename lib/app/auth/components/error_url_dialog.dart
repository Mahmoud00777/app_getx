import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/common_button.dart';
import '../../../components/common_text.dart';
import '../../../utils/constants.dart';

Future<void> errorURLDialog(String title, String text) async {
  return Get.defaultDialog(
      titlePadding: EdgeInsets.zero,
      title: "",
      titleStyle: TextStyle(fontSize: 2),
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Image(
                height: 80,
                width: 80,
                image: AssetImage("assets/icons/error.png")),
          ).animate().fadeIn(delay: 100.ms, duration: 800.ms),
          CommonText(
              text: title,
              color: primaryAppColor,
              fontSize: 14,
              textAlign: TextAlign.center,
              weight: FontWeight.w500),
          SizedBox(height: 5),
          CommonText(
              text: text,
              color: greyShade600,
              fontSize: 12,
              textAlign: TextAlign.center,
              weight: FontWeight.w300),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              openWhatsApp("+923351206668");
              Get.back();
            },
            child: Row(
              children: [
                Image(
                    height: 20,
                    width: 20,
                    image: AssetImage("assets/icons/whatsapp.png")),
                CommonText(text: "   +923351206668", 
                weight: FontWeight.w400,
                color: primaryBlueApp08Opacity)
              ],
            ),
          ),
          SizedBox(height: 5),
          InkWell(
            onTap: () {
              _launchMail();
              Get.back();
            },
            child: Row(
              children: [
                Image(
                    height: 20,
                    width: 20,
                    image: AssetImage("assets/icons/mail.png")),
                CommonText(text: "   info@codessoft.com", 
               weight: FontWeight.w400,
                color: primaryBlueApp08Opacity)
              ],
            ),
          )
        ],
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      radius: 20,
      actions: [
        Column(
          children: [
            CommonButton(
              height: 40,
              width: 100,
              text: "Okay",
              onPress: () {
                Get.back();
              },
            ),
          ],
        ),
      ]);
}

//------- Dial Phone Number
void _launchPhone(final phone) async {
  final tel = Uri.parse('tel:$phone');
  String? num = "+923351206668";

  try {
    if (await canLaunchUrl(tel)) {
      launchUrl(tel);
    } else {
      throw 'Could not dial $tel';
    }
  } catch (e) {
    print('Error dialing $phone: $e');
  }
}

//------- Launch Mail
void _launchMail() async {
  String subject = 'ERPNext Employee HUB';
  String encodedSubject = subject.replaceAll(' ', '%20');
  String body = 'Hello, I need more information about your services.';
  String encodedbody = body.replaceAll(' ', '%20');

  String url =
      'mailto:info@codessoft.com?subject=$encodedSubject&body=$encodedbody';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void openWhatsApp(String phone) async {
  const message = 'Hello, I need more information about ERPNext Employee HUB';
  final encodedMessage = Uri.encodeComponent(message);
  String url = 'https://wa.me/$phone?text=$encodedMessage';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
