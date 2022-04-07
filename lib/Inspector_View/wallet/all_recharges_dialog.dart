 import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Future<void> showAllRechargesDialog(context) async {
  final screenSize = MediaQuery.of(context).size;

  return await showDialog(
      context: context,
      builder: (context) {
        int? value = 1;
        double? kNetPos = 600;

        return StatefulBuilder(builder: (context, setState) {
          Timer(Duration(milliseconds: 2), () {
            setState(() {
              kNetPos = 290.0;
            });
          });
          return Container(
            width: screenSize.width,
            child: AlertDialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(top: 0.0),
              contentPadding: EdgeInsets.all(5),
              content: Center(
                child: SizedBox(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: Text('GGGg')
                ),
              ),
            ),
          );
        });
      });
}
