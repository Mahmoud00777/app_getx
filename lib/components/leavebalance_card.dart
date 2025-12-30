// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:pie_chart/pie_chart.dart';

// class LeaveBalanceCard extends StatelessWidget {
//   final String leaveType;
//   Color? shadowColor;

//   LeaveBalanceCard({this.shadowColor, Key? key, required this.leaveType})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Map<String, double> dataMap = {
//       "Used 500": 10,
//     };

//     // Calculate the sum of values without the "BHD" prefix
//     double sum = 0;
//     dataMap.forEach((key, value) {
//       // Extract the numeric part of the key (excluding "BHD")
//       String numericPart = key.substring(5);
//       // Convert the numeric part to a double and add it to the sum
//       sum += double.parse(numericPart);
//     });

//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.lightBlueAccent, Colors.white],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           bottomRight: Radius.circular(20),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: shadowColor ?? Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 10,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           PieChart(
//             centerTextStyle: TextStyle(
//               color: Color.fromARGB(255, 85, 84, 84),
//               fontWeight: FontWeight.bold,
//             ),
//             centerText: "$sum",
//             chartRadius: 90,
//             ringStrokeWidth: 07,
//             dataMap: dataMap,
//             chartType: ChartType.ring,
//             baseChartColor: Colors.transparent,
//             colorList: [secondaryAppColor, Colors.green, Colors.red],
//             chartValuesOptions: ChartValuesOptions(
//               chartValueBackgroundColor: Colors.transparent,
//               showChartValuesInPercentage: false,
//               showChartValues: false,
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             "Leave Type: $leaveType",
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// // import 'package:flutter/material.dart';
// // import 'package:pie_chart/pie_chart.dart';

// // class LeaveBalanceCard extends StatefulWidget {
// //   const LeaveBalanceCard({super.key});

// //   @override
// //   State<LeaveBalanceCard> createState() => _LeaveBalanceCardState();
// // }

// // List<String> leaveType = [
// //   "Sick Leave",
// //   "Sick",
// //   "Leave Without Pay",
// //   "Privilege Leave",
// //   "Compensatory Off",
// //   "Casual Leave",
// // ];
// // final List<Color> colorList = [
// //   secondaryAppColor,
// //   Colors.green,
// //   Colors.red,
// // ];
// // Map<String, double> dataMap = {
// //   "Used 500": 10,
// // };

// // class _LeaveBalanceCardState extends State<LeaveBalanceCard> {
// //   @override
// //   Widget build(BuildContext context) {
// //     // Calculate the sum of values without the "BHD" prefix
// //     double sum = 0;
// //     dataMap.forEach(
// //       (key, value) {
// //         // Extract the numeric part of the key (excluding "BHD")
// //         String numericPart = key.substring(5);
// //         // Convert the numeric part to a double and add it to the sum
// //         sum += double.parse(numericPart);
// //       },
// //     );
// //     // Map<String, double> combinedMap = {...dataMap};
// //     // for (int i = 0; i < leaveType.length; i++) {
// //     //   combinedMap[leaveType[i]] = 0;
// //     // }
// //     return Container(
// //       decoration: BoxDecoration(
// //         gradient: LinearGradient(
// //           colors: [Colors.lightBlueAccent, Colors.white],
// //           begin: Alignment.topCenter,
// //           end: Alignment.bottomCenter,
// //         ),
// //         borderRadius: BorderRadius.only(
// //           topLeft: Radius.circular(20),
// //           bottomRight: Radius.circular(20),
// //         ),
// //       ),
// //       child: Column(
// //         children: [
// //           PieChart(
// //             centerTextStyle: TextStyle(
// //               color: Color.fromARGB(255, 85, 84, 84),
// //               fontWeight: FontWeight.bold,
// //             ),
// //             centerText: "$sum",
// //             chartRadius: 90,
// //             ringStrokeWidth: 07,
// //             dataMap: dataMap,
// //             chartType: ChartType.ring,
// //             baseChartColor: Colors.transparent,
// //             colorList: colorList,
// //             chartValuesOptions: ChartValuesOptions(
// //               chartValueBackgroundColor: Colors.transparent,
// //               showChartValuesInPercentage: false,
// //               showChartValues: false,
// //             ),
// //           ),
// //           Column(
// //             children: leaveType.map((type) {
// //               return Text(
// //                 type,
// //                 style: TextStyle(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.black,
// //                 ),
// //               );
// //             }).toList(),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
