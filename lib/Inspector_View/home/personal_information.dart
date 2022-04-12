
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inspector_app/Inspector_View/home/personal_information_edit.dart';

import '../../Inspector_Controllers/globals.dart';
import '../../Inspector_Controllers/personal_information_controller.dart';


class PersonalInformation extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {

  final personalInfoController = Get.put(PersonalInformationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: routes_color,

        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: 'Edit Profile',
            onPressed: () {
              Get.to(PersonalInformationEdit());
            },
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // EDIT PROFILE PICTURE
                Obx(() =>  Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  // If no profile picture is fetched, a placeholder Image will be displayed
                  child: personalInfoController.profilePicture.value.path == "" ?
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png',
                    ),
                  ):
                  // display user profile picture.
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        personalInfoController.profilePictureUrl.value//'https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png',
                    ),
                  ),
                ),
                ),
                SizedBox(height: 46.0,),
                // EDIT NAME
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      SizedBox(height: 4.0,),
                      Obx(() => TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: personalInfoController.nameHint.value
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.0,),
//            // EDIT PHONE
//            Container(
//              margin: EdgeInsets.symmetric(horizontal: 8.0),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
//                  Text(
//                    "Username/Phone",
//                    style: TextStyle(
//                        color: Colors.grey
//                    ),
//                  ),
//                  SizedBox(height: 4.0,),
//                  TextField(
//                    decoration: InputDecoration(
//                        hintText: "+99921312 "
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            SizedBox(height: 32.0,),
                // EDIT EMAIL
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(height: 4.0,),
                      Obx(() => TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: personalInfoController.emailHint.value,
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.0,),

                // QrImage(
                //   data: "{\"userId\":\"${user.id!}\",\"userName\":\"${user.name}\"}",
                //   version: QrVersions.auto,
                //   size: 200.0,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
