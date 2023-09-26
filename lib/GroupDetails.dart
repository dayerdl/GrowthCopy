import 'package:flutter/material.dart';
import 'MuscleSplitWidget.dart';


class GroupDetails extends StatelessWidget {
  const GroupDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: MuscleSplitWidget(),
        ),
      ),
    );
  }
}


