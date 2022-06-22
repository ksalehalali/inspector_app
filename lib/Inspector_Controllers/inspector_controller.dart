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
  var inspectorBusesChecked =[].obs;
  var inspectorTicketsChecked =[].obs;
  var ticketChecked ={}.obs;
  var paymentsForBus = [].obs;
  var gotBusesChecked =false.obs;
  var gotTicketsChecked =false.obs;
var ticketIdScanned =''.obs;

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
      print("bus data :: ${data}");
      openCam.value =false;
      getInspectorBusesChecked();
      busScanned.value =true;
      await checkBus();
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
    ticketIdScanned.value = paymentId;
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
      var json = jsonDecode(await response.stream.bytesToString());
      ticketChecked.value =json;
      var data = json['description'];
      ticketChecked.value =data;

      if(json['status'] ==true){
        openCam.value =false;
        Get.dialog(CustomDialogTickets( failed: false,message: 'done',));
      }else{
        Get.dialog(CustomDialogTickets( failed: true,message: data,));

      }

    }
    else {
      print(response.statusCode);
      print(response.reasonPhrase);

    }
update();
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

  //get inspector buses checked
Future getInspectorBusesChecked()async{
    gotBusesChecked.value =false ;
  var headers = {
    'Authorization': 'bearer $myToken',
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('https://route.click68.com/api/ListInspictionBusByInspector'));
  request.body = json.encode({
    "PageSize": "1113",
    "PageNumber": "1"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var json = jsonDecode(await response.stream.bytesToString());
    var data = json['description'];
    print('buses checked :: ${json}');
    inspectorBusesChecked.value = data;
    gotBusesChecked.value =true ;
update();

  }
  else {
    print(response.reasonPhrase);
  }

}

  //check  bus
  Future checkBus()async{
    var headers = {
      'Authorization': 'bearer $myToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/InspectionBus'));
    request.body = json.encode({
      "id":"76ae4d9d-9fff-40cf-f7db-08da3d58147f"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      print('payments for bus  :: ${json}');
      paymentsForBus.value = data;
update();
    }
    else {
      print(response.reasonPhrase);
    }

  }

  Future getTicketsChecked()async{
    gotTicketsChecked.value =false;
    var headers = {
      'Authorization': 'bearer $myToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/ListInspictionUserByInspector'));
    request.body = json.encode({
      "PageNumber": 1,
      "PageSize": 1110
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      print('tickets checked  :: ${json}');
      inspectorTicketsChecked.value = data;
      gotTicketsChecked.value =true;

    }
    else {
      print(response.reasonPhrase);
    }


  }

}