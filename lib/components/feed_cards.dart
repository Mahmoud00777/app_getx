// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pos_app/utils/app_size_config.dart';
import 'package:pos_app/utils/constants.dart';
// import '../app/dashboard/feed/component/post_fullscreen_image.dart';
import '../utils/controllers/data_controller.dart';
import 'common_text.dart';
import 'halfrounded_box.dart';

class FeedCard extends StatefulWidget {
  String content;
  int? comments;
  int? likes;
  String? occupation;
  String timeAgo;
  String username;
  String? userImg;
  List<dynamic>? imageList;
  IconData likeIcon;
  final Function() onLikePress;
  final Function() onComPress;
  final Function() onThreeDot;

  FeedCard({
    super.key,
    required this.content,
    required this.comments,
    required this.likes,
    this.occupation,
    required this.timeAgo,
    required this.username,
    required this.userImg,
    required this.onLikePress,
    required this.onComPress,
    required this.likeIcon,
    this.imageList,
    required this.onThreeDot,
  });

  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  final DataController dataController = Get.put(DataController());
  Future<void> loadGetxData() async {
    await dataController.loadMyData();
  }

  @override
  void initState() {
    super.initState();
    loadGetxData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future<void> imageViewer(String url) async {
  //   final imageProvider = Image.network(url).image;
  //   showImageViewer(
  //       context,
  //       swipeDismissible: true,
  //       useSafeArea: true,
  //       closeButtonColor: grey,
  //       imageProvider, onViewerDismissed: () {
  //     print("dismissed");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return HalfRounded(
      isOutline: true,
      outlineColor: primaryAppColor,
      containerColor: white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 0, right: 0),
              // leading: CircleAvatar(
              //   radius: 22,
              //   backgroundColor: grey,
              //   backgroundImage: AssetImage(widget.userImg.toString()),
              // ),
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: grey.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CommonText(
                    text: widget.username[0].toCapitalized(),
                    weight: FontWeight.w600,
                    color: secondaryAppColor,
                    fontSize: 18,
                  ),
                ),
              ),
              title: CommonText(
                text: widget.username,
                weight: FontWeight.bold,
                fontSize: 16,
              ),
              subtitle: CommonText(text: widget.timeAgo),

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     CommonText(
              //       text: widget.occupation,
              //     ),
              //     CommonText(
              //       text: widget.date,
              //     ),
              //   ],
              // ),
              trailing: PopupMenuButton<int>(
                itemBuilder: (context) => [
                  // popupmenu item 1
                  PopupMenuItem(
                    onTap: widget.onThreeDot,
                    value: 1,
                    // row has two child icon and text.
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("delete".tr),
                      ],
                    ),
                  ),
                ],
                offset: Offset(0, 40),
                // color: Colors.grey,
                elevation: 2,
              ),
            ),
            SizedBox(height: 10),
            CommonText(text: widget.content, fontSize: 16),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children:
                    widget.imageList?.asMap().entries.map<StaggeredGridTile>((
                      entry,
                    ) {
                      int index = entry.key;
                      var image = entry.value;
                      int totalImages = widget.imageList!.length;

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
                            // imageViewer(
                            //     "${dataController.mySavedBaseURL.value}${image["file_url"]}");
                            // Get.to(
                            //   () => PostFullScreenImage(
                            //     imagePaths: widget.imageList ?? [],
                            //     initialIndex: index,
                            //   ),
                            // );
                            print(index);
                          },
                          child: Tile(
                            image:
                                "${dataController.mySavedBaseURL.value}${image["file_url"]}",
                          ),
                        ),
                      );
                    }).toList() ??
                    [], // Handle null safely
              ),

              // child: StaggeredGrid.count(
              //   crossAxisCount: 4,
              //   mainAxisSpacing: 4,
              //   crossAxisSpacing: 4,
              //   children: widget.imageList
              //           ?.map<StaggeredGridTile>(
              //               (image) => StaggeredGridTile.count(
              //                   crossAxisCellCount: 2,
              //                   mainAxisCellCount: 1,
              //                   child: Tile(
              //                     image:
              //                         "${dataController.mySavedBaseURL.value}${image["file_url"]}",
              //                   )))
              //           .toList() ??
              //       [], // Make sure to convert the result to a List if imageList is not null, otherwise provide an empty list.
              // )
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.thumb_up_sharp, color: blue),
                SizedBox(width: 8),
                CommonText(text: widget.likes.toString()),
                Spacer(),
                widget.comments == 0 || widget.comments == 1
                    ? CommonText(text: "${widget.comments} ${"cmt".tr}")
                    : CommonText(text: "${widget.comments} ${"cmts".tr}"),
              ],
            ),
            Divider(color: Colors.black, indent: 6, endIndent: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // widget.onLikePress
                Material(
                  color: transparent,
                  child: InkWell(
                    onTap: widget.onLikePress,
                    child: Icon(widget.likeIcon, color: primaryAppColor),
                  ),
                ),
                // widget.onComPress
                Material(
                  color: transparent,
                  child: InkWell(
                    onTap: widget.onComPress,
                    child: Icon(Icons.comment_outlined, color: primaryAppColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    // required this.index,
    this.image,
    this.extent,
    this.bottomSpace,
  });
  // final int index;
  final String? image;
  final double? extent;
  final double? bottomSpace;
  @override
  Widget build(BuildContext context) {
    final child = Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.shade200,
      ),
      height: extent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/icons/not_found.png', fit: BoxFit.cover),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        child,
        Container(height: bottomSpace, color: Colors.grey),
      ],
    );
  }
}
