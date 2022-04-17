import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../Inspector_View/confirm_sendCredit_screen.dart';
import '../Inspector_View/home/bus_details.dart';
import '../Inspector_View/home/widgets/dialogs.dart';
import '../Inspector_View/main_screen.dart';
import 'current_data.dart';

class InspectorController extends GetxController{
  var openCam =false.obs;
  var busScanned =false.obs;
  var busScannedData = {};

  Future getBusData(String busId)async{

    var headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOYW1lIjoiUm91dGVTdGF0aW9uIiwiUm9sZSI6InN1cGVyQWRtaW4iLCJleHAiOjE2NTE4Mzk4NzAsImlzcyI6IkludmVudG9yeUF1dGhlbnRpY2F0aW9uU2VydmVyIiwiYXVkIjoiSW52ZW50b3J5U2VydmljZVBvdG1hbkNsaWVudCJ9.uYZSA_tE23gy-7zZ8j8dlFeEF-xE4EJmnsjJbTQ57WY',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/GetBus'));
    request.body = json.encode({
      "id":busId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      busScannedData =data;
      print(data);
      openCam.value =false;
      busScanned.value =true;
      Get.to(()=>  const MainScreen( currentPage: 2,));
    }else{
      busScanned.value =false;
      Get.snackbar(
          'Error', 'Error while getting bus dataB',
          duration: 3.seconds, colorText: Colors.red[900]);
      Get.to(()=> const MainScreen(currentPage: 0,));

    }


  }
  Future checkTickets(String paymentId,String userId,)async{
    var headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOYW1lIjoiOTg4MjQ1NjciLCJSb2xlIjoiSW5zcGVjdG9yIiwiZXhwIjoxNjUyNzgzNTcxLCJpc3MiOiJJbnZlbnRvcnlBdXRoZW50aWNhdGlvblNlcnZlciIsImF1ZCI6IkludmVudG9yeVNlcnZpY2VQb3RtYW5DbGllbnQifQ.bgfEH_ENujNt-aixuFFd1XbkZc2yIMUFCzggOIf5jZs',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/CheckPaymentByInspector'));
    request.body = json.encode({
      "PaymentId": paymentId,
      "UserId":userId,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      openCam.value =false;
      Get.dialog(CustomDialogTickets( failed: false));
    }
    else {
      print(response.statusCode);
      print(response.reasonPhrase);
      Get.dialog(CustomDialogTickets( failed: true));

    }

  }

  Future sendCreditRequest()async{

    var headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOYW1lIjoicHJvbW90ZXI5OCIsIlJvbGUiOiJQcm9tb3RlciIsImV4cCI6MTY1Mjc4MzAyNSwiaXNzIjoiSW52ZW50b3J5QXV0aGVudGljYXRpb25TZXJ2ZXIiLCJhdWQiOiJJbnZlbnRvcnlTZXJ2aWNlUG90bWFuQ2xpZW50In0.OHCvZjl745patjv9uipuVl5Vue1mRpx_GpqSg6n5wck',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/ChargeWalletByPromoter'));
    request.body = json.encode({
      "api_key": "\$FhlF]3;.OIic&{>H;_DeW}|:wQ,A8",
      "api_secret": "Z~P7-_/i!=}?BIwAd*S67LBzUo4O^G",
      "UserID": paySaved.uid,
      "PromoterID": "1d31cd22-d1a7-453d-a0e8-43aebe2d7fba",
      "invoiceValue": paySaved.value
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      print(await response.stream.bytesToString());

      openCam.value =false;
      Get.offUntil(MaterialPageRoute(builder: (context)=>const MainScreen(currentPage: 0,)), (route) => false);

      Get.dialog(CustomDialog( sendFailed: false));

    }
    else {
      print(response.statusCode);

      print(response.reasonPhrase);
    }


  }

}