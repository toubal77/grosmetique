import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/material.dart';

class ConnextionStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConnectionStatusBar(
      height: 250, // double: default height
      width: double.maxFinite, // double: default width
      color: Colors.redAccent, // Color: default background color
      endOffset: const Offset(
          0.0, 0.0), // Offset: default animation finish point offset
      beginOffset: const Offset(
          0.0, -1.0), // Offset: default animation start point offset
      animationDuration: const Duration(
          milliseconds: 200), // Duration: default animation duration
      // Text: default text
      title: const Text(
        'Please check your internet connection',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
