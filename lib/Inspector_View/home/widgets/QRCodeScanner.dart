// QR Code Scanner
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspector_app/Inspector_Controllers/current_data.dart';
import 'package:inspector_app/Inspector_Controllers/inspector_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../confirm_sendCredit_screen.dart';


class QRScanner extends StatefulWidget {
  final String scanType;
  BuildContext? context;

  QRScanner({Key? key, this.context,required this.scanType}) : super(key: key);

  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final InspectorController inspectorController = Get.find();

  Barcode? result;
  QRViewController? controller;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            controller!.pauseCamera();
    inspectorController.openCam.value =false;

          },
          child: Icon(Icons.arrow_back),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                  'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      print(scanData.code);
      controller.stopCamera();
      var json = jsonDecode(result!.code!);


     if(widget.scanType =='Bus'){
       var busId = json['busId'];
       var b = json['busId'];
       inspectorController.getBusData(busId);
     }else if(widget.scanType =='Ticket'){
       var userId = json['userId'];
       var paymentId = json['paymentId'];
       inspectorController.checkTickets(paymentId, userId);

    }else if(widget.scanType =='Send'){
      var userId = json['userId'];
      var userName = json['userName'];
      print('send money to userId : $userName');
      paySaved.userName =userName;
      paySaved.uid = userId;

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const ConfirmSend()));
     }});
    }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
