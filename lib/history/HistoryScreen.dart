// import 'package:Growth/sessiontracker/WorkoutSession.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
// import 'package:intl/intl.dart';
// import '../SVGWidgets.dart';
// import '../sessiontracker/ExerciseSession.dart';
// import '../sessiontracker/FireStoreService.dart';
// import '../sessiontracker/FirestoreListViewWithHeaders.dart';
// import '../sessiontracker/WorkoutHistoryDetails.dart';
//
// class HistoryScreen extends StatelessWidget {
//   const HistoryScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Workout History'),
//         ),
//         body: Padding(
//             padding: const EdgeInsets.only(left: 4, right: 4),
//             child: HistoryListViewWithHeaders(
//               query: FireStoreService().getHistoryQuery(),
//               monthFormatter: (DateTime date) => DateFormat.yMMM().format(date),
//             )));
//   }
// }
