import 'package:flutter/material.dart';

import '../../../Inspector_Controllers/globals.dart';

Widget Header (size){
  return Container(
    width: double.infinity,
    height: size.height *0.1,

      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            routes_color6,
            routes_color,
          ]

      ),
        boxShadow: [
          BoxShadow(
            color: Colors.red,
          ),
          BoxShadow(
            color: routes_color7,
            blurRadius: 6.0,
            spreadRadius: 0.5,
            offset: Offset(0.7, 0.7),
          )
        ]
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 19.0,bottom: 12),
      child: Image.asset('assets/images/logo/logo_white_300.png',height: 30,width: 30,fit: BoxFit.contain,),
    )
  );
}