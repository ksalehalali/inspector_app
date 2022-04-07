import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Inspector_Models/charge_toSave_model.dart';
import '../Inspector_Models/payment_saved_model.dart';
import 'current_data.dart';

class PaymentController extends GetxController {
  var paymentDone = false.obs;
  var directPaymentDone = false.obs;
  var paymentFailed = false.obs;
  var directPaymentFailed = false.obs;
  var totalOfMyPayments = 0.obs;
  var myBalance = '0.0'.obs;
  var recharges = <ChargeSaved>[].obs;
  var payments = <PaymentSaved>[].obs;
  var gotMyBalance = false.obs;
  var gotPayments = false.obs;
  var gotRecharges = false.obs;
  var openCam =false.obs;
  int indexA = 0;
  int indexB = 0;


  Future<bool> pay(bool isDirect) async {
    var headers = {
      'Authorization': 'bearer $myToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/PaymentMyWallet'));

    if(isDirect ==false){
      request.body = json.encode({
        "api_key": "\$FhlF]3;.OIic&{>H;_DeW}|:wQ,A8",
        "api_secret": "Z~P7-_/i!=}?BIwAd*S67LBzUo4O^G",
       // "Value":   paymentSaved.value,
       // "TripID": tripToSave.id,
       // "BusId": paymentSaved.busId
      });
    }else{
      request.body = json.encode({
        "api_key": "\$FhlF]3;.OIic&{>H;_DeW}|:wQ,A8",
        "api_secret": "Z~P7-_/i!=}?BIwAd*S67LBzUo4O^G",
        //"Value":   paymentSaved.value,
        //"BusId": paymentSaved.busId
      });
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var jsonResponse = jsonDecode(await response.stream.bytesToString());
    print(jsonResponse);

    if (jsonResponse['status']== true) {
      //
      // user.totalBalance = double.parse(jsonResponse['description']['total']);
      //  paymentSaved.id = jsonResponse['description']['paymentId'];
      //  paymentSaved.routeName = jsonResponse['description']['routeName'];
      //  paymentSaved.userName = jsonResponse['description']['userName'];
      print('value payed :: ${jsonResponse}');

      openCam.value =false;

      update();
      return true;
    }
    else {
      openCam.value =false;
      var json = jsonDecode(await response.stream.bytesToString());
      print(json);
      if(isDirect==true){
        directPaymentDone.value = false;
        directPaymentFailed.value =true;
        openCam.value =false;

      }{
        paymentDone.value = false;
        paymentFailed.value =true;
        openCam.value =false;

      }
update();
      return false;
    }
  }

  Future<bool> recharge({required double invoiceValue,required int invoiceId,required String paymentGateway}) async {
    var headers = {
      'Authorization':
          'bearer $myToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://route.click68.com/api/ChargeMyWallet'));
    request.body = json.encode({
      "api_key": "\$FhlF]3;.OIic&{>H;_DeW}|:wQ,A8",
      "api_secret": "Z~P7-_/i!=}?BIwAd*S67LBzUo4O^G",
      "invoiceValue": invoiceValue,
      "invoiceId": invoiceId,
      "paymentGateway": paymentGateway
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    return true;
  }

  //get my wallet
  Future getMyWallet() async {
    var headers = {
      'Authorization':
          'bearer $myToken'
    };
    var url =  Uri.parse('https://route.click68.com/api/GetWallet');
    var res = await  http.get(url,headers: headers);
    print(res.body);
    var jsonResponse = jsonDecode(res.body);
    if (res.statusCode == 200) {
      gotMyBalance.value = true;
      myBalance.value = jsonResponse['description']['total'];
      print(res.body);
    } else {
      print(res.reasonPhrase);
    }

    return res.body;
  }

  //get list of recharges
  Future getMyListOfRecharges() async {
    gotRecharges.value =false;

    recharges.clear() ;


    var headers = {
      'Authorization': 'bearer $myToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/ListChrgingWalletByUser'));
    request.body = json.encode({
      "PageNumber": 0,
      "PageSize": 100
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
        for(int i =0; i < data.length; i++){
          recharges.add(
              ChargeSaved(
               id: data[i]['id'],
                userName: data[i]['userName'],
                invoiceValue: double.parse(data[i]['value']),
                createdDate: data[i]['date'],
                paymentGateway: data[i]['paymentGateway'],
                invoiceId: data[i]['invoiceId']
              )
          );

        }
        gotRecharges.value =true;
        update();
    }
    else {
      print(response.reasonPhrase);
    }
    // if(gotPayments.value ==true && gotRecharges.value==true){
    //   sort();
    // }
  }

  //get list of payments
  Future getMyListOfPayments() async {
    gotPayments.value =false;

    payments.clear() ;
    var headers = {
      'Authorization': 'bearer $myToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/ListPaymentWalletByUser'));
    request.body = json.encode({
      "PageNumber": 1,
      "PageSize": 150
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      totalOfMyPayments.value = json['total'];
print('payment ::${data[0]}');
      for(int i =0; i < data.length; i++){
        payments.add(
                PaymentSaved (
                  userName: data[i]['userName'],
                  createdDate: data[i]['date'],
                  value: double.parse(data[i]['value']),
                  id: data[i]['id'],
                  routeName: data[i]['routeName']??'',
                  date: data[i]['date'],
                  userBalance: data[i]['total']
            )
        );

      }
      gotPayments.value =true;
      update();

    }
    else {
      print(response.reasonPhrase);
    }

  }
}
