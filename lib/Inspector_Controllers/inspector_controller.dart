import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../Inspector_View/home/bus_details.dart';

class InspectorController extends GetxController{
  var openCam =false.obs;
  var busScanned = {};

  Future getBusData(String busId)async{

    var headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOYW1lIjoiUm91dGVTdGF0aW9uIiwiUm9sZSI6InN1cGVyQWRtaW4iLCJleHAiOjE2NTE4Mzk4NzAsImlzcyI6IkludmVudG9yeUF1dGhlbnRpY2F0aW9uU2VydmVyIiwiYXVkIjoiSW52ZW50b3J5U2VydmljZVBvdG1hbkNsaWVudCJ9.uYZSA_tE23gy-7zZ8j8dlFeEF-xE4EJmnsjJbTQ57WY',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/GetBus'));
    request.body = json.encode({
      "id":"7869991b-9dcb-480f-f503-08da163583a3"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      busScanned =data;
      print(data);
      openCam.value =false;
      Get.to(()=> const BusDetails());
    }


  }

}