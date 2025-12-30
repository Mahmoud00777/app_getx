// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class SearchBox extends StatelessWidget {
  String? hint;
  void Function(String)? onSub;
  void Function(String)? onChange;
  void Function()? onCancel;
  SearchBox({
    super.key,
    required this.onSub,
    required this.hint,
    required this.searchController,
    this.onChange,
    this.onCancel,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.white,
      ),
      child: TextField(
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: grey,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
          hintText: "${'search'.tr} ${'$hint'.tr}",
          prefixIcon: Icon(Icons.search, color: secondaryAppColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
          ),
          suffixIcon: onCancel != null
              ? Visibility(
                  visible: searchController.text != "",
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel_rounded,
                      color: Colors.grey.shade300,
                    ),
                    onPressed: onCancel,
                  ),
                )
              : const SizedBox.shrink(),
        ),
        controller: searchController,
        onSubmitted: onSub,
        onChanged: onChange,
      ),
    );
  }
}

// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';

// class SearchBox extends StatelessWidget {
//   String? hint;
//   void Function(String)? onSub;
//   void Function(String)? onChange;
//   SearchBox({
//     super.key,
//     required this.onSub,
//     required this.hint,
//     required this.searchController,
//     this.onChange,
//   });

//   final TextEditingController searchController;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: TextField(
//         textInputAction: TextInputAction.search,
//         decoration: InputDecoration(
//           hintText: 'Search $hint',
//           prefixIcon: Icon(Icons.search),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.all(16.0),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//             borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//             borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
//           ),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.cancel_rounded, color: Colors.grey.shade300),
//             onPressed: () {
//               searchController.clear();
//             },
//           ),
//         ),
//         controller: searchController,
//         onSubmitted: onSub,
//         onChanged: onChange,
//       ),
//     );
//   }
// }
