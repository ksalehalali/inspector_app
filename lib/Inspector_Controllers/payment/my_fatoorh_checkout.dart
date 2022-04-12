import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';

import '../../Inspector_View/main_screen.dart';
import '../payment_controller.dart';

class MyFatoorah {
  final PaymentController walletController = Get.find();
  Future initiate(
      BuildContext context, double amount, int paymentMethodId) async {
    var request =
        new MFInitiatePaymentRequest(amount, MFCurrencyISO.KUWAIT_KWD);

    MFSDK.initiatePayment(
        request,
        MFAPILanguage.EN,
        (MFResult<MFInitiatePaymentResponse> result) => {
              if (result.isSuccess())
                {
                  print('charge successful'),
                  print(result.response!.toJson().toString()),
                }
              else
                {
                  print('charge field'),

                  print(result.error!.message)}
            });
    setAppBar();
    executePayment(context, amount, paymentMethodId);
    return request;
  }

  var res;

  //Execute Payment
  Future executePayment(
      BuildContext context, double amount, int paymentMethodId) async {
    int paymentMethod = paymentMethodId;

    var request = new MFExecutePaymentRequest(
      paymentMethod,
      amount,
    );

    MFSDK.executePayment(
        context,
        request,
        MFAPILanguage.EN,
        (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {
                  res = result.response!.toJson(),
                  walletController.recharge(invoiceId:res['InvoiceId'],invoiceValue: res['InvoiceValue'],paymentGateway:res['InvoiceTransactions'][0]['PaymentGateway'],  ),

                  print(result.response!.toJson().toString()),
                  print("booody :: ${result.response!.toJson()}"),
                  // chargeSaved.invoiceId = res['InvoiceId'],
                  // chargeSaved.invoiceValue = res['InvoiceValue'],
                  // chargeSaved.createdDate = res['CreatedDate'],
                  // chargeSaved.paymentGateway =
                  //     res['InvoiceTransactions'][0]['PaymentGateway'],
                  Get.offAll(const MainScreen(currentPage: 0,))
                }
              else
                {
                  print('wrong with recharge'),
                  print(result.error!.message)}
            });
    return request;
  }

  //Direct Payment / Tokenization
  Future directPayment(BuildContext context) async {
    MFCardInfo(cardToken: "put your token here");
    // The value 2 is the paymentMethodId of Visa/Master payment method.
// You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    int paymentMethod = 2;

    var request = new MFExecutePaymentRequest(paymentMethod, 0.100);

// var mfCardInfo = new MFCardInfo(cardToken: "Put your token here");

    var mfCardInfo = new MFCardInfo(
        cardToken: '2ewwwd',
        cardNumber: "4508750015741019",
        expiryMonth: "05",
        expiryYear: "22",
        securityCode: "100",
        bypass3DS: false,
        saveToken: false);

    MFSDK.executeDirectPayment(
        context,
        request,
        mfCardInfo,
        MFAPILanguage.EN,
        (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
              if (result.isSuccess())
                {print(result.response!.toJson().toString())}
              else
                {print(result.error!.message)}
            });
    return request;
  }

  //Payment Enquiry
  Future paymentEnquiry(BuildContext context) async {
    var request = MFPaymentStatusRequest(
        invoiceId: "1099724", paymentId: '0706109972487861669');

    MFSDK.getPaymentStatus(
        MFAPILanguage.EN,
        request,
        (MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {print(result.response!.toJson().toString())}
              else
                {print(result.error!.message)}
            });
    return request;
  }

  //set app bar
  void setAppBar() {
    MFSDK.setUpAppBar(
        title: "Routes",
        titleColor: Colors.white, // Color(0xFFFFFFFF)
        backgroundColor: Colors.blue.shade900, // Color(0xFF000000)
        isShowAppBar: true); // For Android platform o
  }
}
