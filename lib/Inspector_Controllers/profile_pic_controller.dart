
import 'dart:io';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicController extends GetxController {

//  File? profilePictureFile;
  var profilePictureFile = new File("").obs;
  var isProfilePictureSelected = false.obs;




  Future<void> pickCameraImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);


    profilePictureFile.value = File(image!.path);

    isProfilePictureSelected.value = true;

      print("a3hhhhhhhhhhhhhhh ${profilePictureFile.value}");
      print(profilePictureFile.value.path);
//    path = image.path;
  }

  Future<void> pickGalleryImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    profilePictureFile.value = File(image!.path);

    isProfilePictureSelected.value = true;

    print("a3hhhhhhhhhhhhhhh ${profilePictureFile.value}");
    print(profilePictureFile.value.path);
//    path = image.path;
  }

}