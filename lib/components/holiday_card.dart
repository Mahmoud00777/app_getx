// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:unifyrh/components/halfrounded_box.dart';

// import '../utils/constants.dart';
// import 'common_text.dart';

// class HolidayCard extends StatelessWidget {
//   String day;
//   String desc;

//   HolidayCard({
//     Key? key,
//     required this.day,
//     required this.desc,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return HalfRounded(
//       containerColor: Colors.white,
//       isOutline: true,
//       outlineColor: primaryAppColor,
//       child: Container(
//         padding: EdgeInsets.all(20),
//         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(12),
//             bottomRight: Radius.circular(12),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CommonText(
//               text: "Holiday: $day",
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             CommonText(
//               text: "Description: $desc",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
