import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:get/get.dart";
import "package:pos_app/components/common_text.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../components/common_appbar.dart";
import "../../../utils/constants.dart";
import "../components/full_screen_image.dart";
import "../components/info_image_tile.dart";

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: CustomAppbarClass(title: 'info'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: "About",
                color: greyShade600,
                fontSize: 16,
                weight: FontWeight.w400,
              ),
              Divider(),
              CommonText(
                text:
                    "ERPNext Employee HUB is a powerful Employee Self Service (ESS) solution designed to simplify and streamline your ESS processes.",
                weight: FontWeight.w300,
                fontSize: 16,
              ),
              SizedBox(height: 15),
              CommonText(
                text: "Pricing",
                color: greyShade600,
                fontSize: 16,
                weight: FontWeight.w400,
              ),
              Divider(),
              Text.rich(
                TextSpan(
                  text: 'The ERPNext Employee Hub is a paid app.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    height: 1.2,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '\$10',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryAppColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' per month per ERPNext site, with unlimited users.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              CommonText(
                text:
                    "To activate it on your ERPNext site, please contact us via:",
                weight: FontWeight.w300,
                fontSize: 16,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _launchMail();
                    },
                    child: Column(
                      children: [
                        Image(
                          height: 30,
                          width: 30,
                          image: AssetImage("assets/icons/mail.png"),
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 5),
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
                    },
                    child: Column(
                      children: [
                        Image(
                          height: 30,
                          width: 30,
                          image: AssetImage("assets/icons/whatsapp.png"),
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 5),
                        CommonText(
                          text: "WhatsApp",
                          fontSize: 16,
                          weight: FontWeight.w400,
                          color: grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              CommonText(
                text: "Instructions",
                color: greyShade600,
                fontSize: 16,
                weight: FontWeight.w400,
              ),
              Divider(),
              CommonText(
                text:
                    "Our technician will assist by installing an additional ERPNext app on your site. If you prefer to handle the installation yourself, kindly share your GitHub account, and we will provide the app. Alternatively, we can install it for you, but we will require SSH access to your ERPNext server or Frappe Cloud access if hosted there.",
                weight: FontWeight.w300,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              CommonText(
                text:
                    "By installing this additional app, you’ll gain features like defining user locations within your ERPNext site, a dedicated page to view attendance data sourced from the Employee Checkin doctype, as well as access to Feed Posts and Poll Voting functionalities.",
                weight: FontWeight.w300,
                fontSize: 16,
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.center,
                child: StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children:
                      imageList.asMap().entries.map<StaggeredGridTile>((entry) {
                        int index = entry.key;
                        var image = entry.value;
                        int totalImages = imageList.length;

                        int crossAxisCellCount =
                            2; // Default value for images in larger sets
                        int mainAxisCellCount = 1; // Default single row height

                        switch (totalImages) {
                          case 1:
                            // One image takes up the entire space
                            crossAxisCellCount = 4;
                            mainAxisCellCount = 2;
                            break;
                          case 2:
                            // Two images, each takes up half of the grid width
                            crossAxisCellCount = 2;
                            mainAxisCellCount = 2;
                            break;
                          case 3:
                            // Three images: first one larger, next two smaller
                            if (index == 0) {
                              crossAxisCellCount = 2; // First image is wider
                              mainAxisCellCount = 2;
                            } else {
                              crossAxisCellCount =
                                  2; // Subsequent images share the next row
                              mainAxisCellCount = 1;
                            }
                            break;
                          case 4:
                            // Four images uniformly
                            crossAxisCellCount = 2;
                            mainAxisCellCount = 1;
                            break;
                        }

                        return StaggeredGridTile.count(
                          crossAxisCellCount: crossAxisCellCount,
                          mainAxisCellCount: mainAxisCellCount,
                          child: InkWell(
                            onTap: () {
                              // imageViewer(image);
                              Get.to(
                                () => FullScreenImageScreen(
                                  imagePaths: imageList,
                                  initialIndex: index,
                                ),
                              );

                              print(index);
                            },
                            child: InfoImageTile(image: image),
                          ),
                        );
                      }).toList() ??
                      [], // Handle null safely
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //----------------------------------------------- Custom Functions
  //
  List<dynamic> imageList = [
    "assets/images/image_01.jpeg",
    "assets/images/image_02.jpeg",
    "assets/images/image_03.jpeg",
    "assets/images/image_04.jpeg",
  ];

  //------- Launch Mail
  void _launchMail() async {
    String subject = 'Request for Information on ERPNext Employee Hub';
    String encodedSubject = subject.replaceAll(' ', '%20');
    String body =
        'Hello Codes Soft 👋🏻, I am interested in purchasing the ERPNext Employee Hub Attendance app.';
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
        'Hello Codes Soft 👋🏻, I am interested in purchasing the ERPNext Employee Hub Attendance app.';
    final encodedMessage = Uri.encodeComponent(message);
    String url = 'https://wa.me/$phone?text=$encodedMessage';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
