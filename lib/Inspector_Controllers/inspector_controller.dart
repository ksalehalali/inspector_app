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
      'Authorization': 'Bearer $myToken',
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
      'Authorization': 'Bearer $myToken',
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
      'Authorization': 'Bearer $myToken',
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