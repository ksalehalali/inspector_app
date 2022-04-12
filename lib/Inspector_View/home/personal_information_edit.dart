import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Inspector_Controllers/globals.dart';
import '../../Inspector_Controllers/personal_information_controller.dart';
import '../../Inspector_Controllers/profile_pic_controller.dart';


class PersonalInformationEdit extends StatefulWidget {
  const PersonalInformationEdit({Key? key}) : super(key: key);

  @override
  _PersonalInformationEditState createState() => _PersonalInformationEditState();
}

class _PersonalInformationEditState extends State<PersonalInformationEdit> {
  final personalInfoController = Get.put(PersonalInformationController());
  final profilePicController = Get.put(ProfilePicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: routes_color,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Get.size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // EDIT PROFILE PICTURE
                Column(
                  children: [
                    Obx(() =>  Container(
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      // If user changed image, new one will be displayed.
                      child: profilePicController.profilePictureFile.value.path != "" ?
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: FileImage(
                          profilePicController.profilePictureFile.value,
                        ),
                        // If no profile picture is fetched, a placeholder Image will be displayed
                      ): personalInfoController.profilePictureUrl.value == "" ?
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
                            //profilePicController.profilePictureFile.value,
                            personalInfoController.profilePictureUrl.value, //'https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png',
                        ),
                      ),
                    ),),
                    SizedBox(height: 8.0,),
                    GestureDetector(
                      onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            print("Ssssssssssssssssss");
                            return AlertDialog(
                              title:  Text(
                                "Add a profile picture",
                                style: TextStyle(
                                    color: Color.fromRGBO(46, 96, 113, 1),
                                    fontSize: 16
                                ),
                              ),
                              // CHOOSE IMAGE RESOURCE
                              content: Container(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // FROM CAMERA
                                    Container(
                                      child: ElevatedButton(
                                        onPressed: () async{
                                          await profilePicController.pickCameraImage();
                                        },
                                        child: Text(
                                            "From Camera"
                                        ),
                                      ),
                                    ),
                                    // FROM GALLERY
                                    Container(
                                      child: ElevatedButton(
                                        onPressed: () async{
                                          await profilePicController.pickGalleryImage();
                                        },
                                        child: Text(
                                            "From Gallery"
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: Text("Ok"),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                      ),
                      child: Text(
                        "Change Profile Picture",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0,),
                    // EDIT NAME
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
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
                            controller: personalInfoController.nameController,
                            decoration: InputDecoration(
                                hintText: personalInfoController.nameHint.value
                            ),
                          ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.0,),
                    // EDIT EMAIL
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
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
                            controller: personalInfoController.emailController,
                            decoration: InputDecoration(
                              hintText: personalInfoController.emailHint.value,
                            ),
                          ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.0,),
                  ],
                ),

                // SAVE CHANGES BUTTON
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      width: Get.size.width * 0.9,
                      child:  Obx(() => ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(routes_color),
                        ),
                        onPressed: () async{
                          personalInfoController.isSaveLoading.value = true;
                          personalInfoController.editInfoConfirmation(profilePicController.profilePictureFile.value);
                          personalInfoController.isSaveLoading.value = false;
//                    await personalInfoController.editPersonalInformation();
//                    await personalInfoController.editProfilePictureInformation(profilePicController.profilePictureFile.value);
                        },
                        child: !personalInfoController.isSaveLoading.value ? Text(
                          "SAVE",
                        ): Container(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(color: Colors.white,),
                        ),
                      ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
