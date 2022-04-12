import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Inspector_Controllers/current_data.dart';


class CustomDialog extends StatelessWidget {
  bool sendFailed;

  CustomDialog({Key? key, required this.sendFailed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15.0,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding:
              EdgeInsets.only(top: 66.0, bottom: 16.0, left: 15.0, right: 15.0),
          margin: EdgeInsets.only(top: 34.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 0.0))
              ]),
          child:  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,

                    children: [
                       Center(
                        child: Text(
                          'Transfer Done',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green[700],),
                        ),
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        'Transfer Id ',
                        style: TextStyle(fontSize: 13),
                      ),
                      const Text(
                        '121212',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      const Text(
                        'User ',
                        style: TextStyle(fontSize: 14),
                      ),
                       Text(
                       '${paySaved.userName}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      const Text(
                        'Amount ',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        paySaved.value!.toStringAsFixed(3),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Center(
                          child: Icon(
                        Icons.done,
                        size: 66,
                        color: Colors.green[800],
                      )),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      )
                    ],
                  ))



    ),
        Positioned(
            top: 0.0,
            left: 16.0,
            right: 16.0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 44,
              child:sendFailed==false? SvgPicture.asset(
                "assets/images/done.svg",
                width: 100,
                height: 100,
                color: Colors.green[700],
              ):SvgPicture.asset(
                "assets/images/feild.svg",
                width: 100,
                height: 100,
                //color: routes_color,
              ),
            ))
      ]);
  }
}
