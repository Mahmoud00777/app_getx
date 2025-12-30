// ignore_for_file: must_be_immutable, unnecessary_statements, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:pos_app/utils/app_size_config.dart';

import '../utils/constants.dart';
import 'common_text.dart';
import 'halfrounded_box.dart';

class PollCard extends StatefulWidget {
  String content;
  String centerText2;
  String centerText3;
  String? centerText4;
  int? commentCount;
  int? likeCount;
  String occupation;
  String timeAgo;
  String username;
  String? userImg;
  IconData likeIcon;
  final Function() onLikePress;
  final Function() onComPress;
  final Function() onThreeDot;
  List<dynamic> list;
  bool isExpired;

  PollCard({
    super.key,
    required this.content,
    required this.centerText2,
    required this.centerText3,
    this.centerText4,
    required this.commentCount,
    required this.likeCount,
    required this.occupation,
    required this.timeAgo,
    required this.username,
    required this.userImg,
    required this.onLikePress,
    required this.onComPress,
    required this.likeIcon,
    required this.list,
    required this.isExpired,
    required this.onThreeDot,
  });

  @override
  _PollCardState createState() => _PollCardState();
}

class _PollCardState extends State<PollCard> {
  int yes = 120;
  int no = 40;
  int yes2 = 90;
  int no2 = 70;
  int? selectedOption;
  int totalCount = 0;
  int totalVote = 0;

  void getTotalVotes() {
    totalCount = widget.list.fold<int>(
      0,
      (int previousValue, element) => previousValue + (element['count'] as int),
    );

    print("Total count is: $totalCount");
  }

  @override
  void initState() {
    super.initState();
    getTotalVotes();
    totalVote = (totalCount == 0 ? 1 : totalCount);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HalfRounded(
      isOutline: true,
      outlineColor: primaryAppColor,
      containerColor: white,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // CommonText(text: widget.isExpired.toString()),
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
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CommonText(
                    //   text: widget.occupation,
                    // ),
                    CommonText(text: widget.timeAgo),
                  ],
                ),
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
                          Text("Delete"),
                        ],
                      ),
                    ),
                  ],
                  offset: Offset(0, 40),
                  // color: Colors.grey,
                  elevation: 2,
                ),
                // trailing: IconButton(
                //   onPressed: () {},
                //   icon: Icon(Icons.more_vert),
                // ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade300, width: 0.7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(text: widget.content, fontSize: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        addVote() {
                          setState(() {
                            widget.list[index]["count"]++;
                            totalVote++;
                            totalCount++;
                          });
                        }

                        bool isExpired = !widget.isExpired;
                        return Column(
                          children: [
                            Row(
                              children: [
                                Radio<int>(
                                  value: index,
                                  activeColor: secondaryAppColor,
                                  groupValue: selectedOption,
                                  onChanged: (int? value) {
                                    print("1: $isExpired");
                                    isExpired
                                        ? setState(() {
                                            print("2: $isExpired");
                                            isExpired
                                                ? selectedOption = value!
                                                : null;
                                            addVote();
                                            setState(() {
                                              isExpired = true;
                                              widget.isExpired = true;
                                              // _isVoted = true;
                                            });
                                          })
                                        : null;
                                  },
                                ),
                                CommonText(
                                  text: widget.list[index]["options"] ?? "---",
                                  fontSize: 16,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 15),
                                Flexible(
                                  child: LinearProgressIndicator(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    minHeight: 10,
                                    color: Colors.lightBlueAccent,
                                    backgroundColor: Colors.grey.shade200,
                                    value: widget.isExpired == true
                                        ? (widget.list[index]["count"] /
                                              totalVote)
                                        : 0,
                                    // value: (currentVote / totalVote),  //total vote should not be Zero
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 5),
                        Icon(Icons.stop, size: 10),
                        SizedBox(width: 5),
                        totalCount == 0 || totalCount == 1
                            ? CommonText(text: "$totalCount vote")
                            : CommonText(text: "$totalCount votes"),
                        Spacer(),
                        CommonText(
                          text: widget.isExpired == true ? "Expired " : " ",
                          fontSize: 14,
                          color: widget.isExpired == true ? red : green,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Row(
              //   children: [
              //     Icon(
              //       Icons.thumb_up_sharp,
              //       color: Colors.blue,
              //     ),
              //     SizedBox(
              //       width: 8,
              //     ),
              //     CommonText(
              //       text: widget.likeCount.toString(),
              //     ),
              //     Spacer(),
              //     widget.commentCount == 0 || widget.commentCount == 1
              //         ? CommonText(
              //             text: "${widget.commentCount} comment",
              //           )
              //         : CommonText(
              //             text: "${widget.commentCount} comments",
              //           )
              //   ],
              // ),
              // Divider(
              //   color: Colors.black,
              //   indent: 6,
              //   endIndent: 6,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     // widget.onLikePress
              //     Material(
              //       color: transparent,
              //       child: InkWell(
              //           onTap: widget.onLikePress,
              //           child: Icon(widget.likeIcon, color: primaryAppColor)),
              //     ),
              //     // widget.onComPress
              //     Material(
              //       color: transparent,
              //       child: InkWell(
              //           onTap: widget.onComPress,
              //           child: Icon(Icons.comment_outlined,
              //               color: primaryAppColor)),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  //----------- Comment Bottomsheet
}
