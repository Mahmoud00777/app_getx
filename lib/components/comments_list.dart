// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CommentList extends StatelessWidget {
  String username;
  String commentBody;
  String time;

  CommentList({
    super.key,
    required this.username,
    required this.commentBody,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: primaryAppColor,
        radius: 14,
        child: Icon(Icons.person, color: Colors.white, size: 16),
      ),
      title: Text(username),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(commentBody), Text(time)],
      ),
    );
  }
}
