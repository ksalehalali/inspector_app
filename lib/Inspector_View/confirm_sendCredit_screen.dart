import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspector_app/Inspector_View/wallet/balance_calculator.dart';

import '../Inspector_Controllers/current_data.dart';
import '../Inspector_Controllers/globals.dart';
import '../Inspector_Controllers/inspector_controller.dart';

class ConfirmSend extends StatefulWidget {
  const ConfirmSend({Key? key}) : super(key: key);

  @override
  _ConfirmSendState createState() => _ConfirmSendState();
}

class _ConfirmSendState extends State<ConfirmSend> {

  final InspectorController inspectorController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Send'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 00.0,
        foregroundColor: Colors.black,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const BalanceCalculator(chargeAmount: false,)));
          },
          child: const Icon(Icons.arrow_back,size: 28,color: Colors.black,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right:14.0,left: 14.0,),
        child: Column(
          children:  [
            SizedBox(height:260),
            Padding(
              padding: const EdgeInsets.only(left: 4.0,top: 15,bottom:15),
              child: Row(
                children: [
                  const Text('The Recipient : ',style:TextStyle(fontSize:16,color: Colors.black87,fontWeight:FontWeight.w400)),
                  Text(' ${paySaved.userName}',style:const TextStyle(fontSize:18,color: Colors.black,fontWeight:FontWeight.w800)),
                ],
              ),
            ),
            Divider(thickness: 2,),
            Padding(
              padding: const EdgeInsets.only(left: 4.0,top: 15,bottom:15),
              child: Row(
                children: [
                  const Text('User Id : ',style:TextStyle(fontSize:16,color: Colors.black87,fontWeight:FontWeight.w400)),
                  Text(' ${paySaved.uid}',style:const TextStyle(fontSize:14,color: Colors.black,fontWeight:FontWeight.w800)),
                ],
              ),
            ),
            Divider(thickness: 2,),
            Padding(
              padding: const EdgeInsets.only(left: 4.0,top: 15,bottom:15),
              child: Row(
                children: [
                  const Text('Amount :  ',style:TextStyle(fontSize:16,color: Colors.black87,fontWeight:FontWeight.w400)),
                  Text(paySaved.value!.toStringAsFixed(3),style:const TextStyle(fontSize:18,color: Colors.black,fontWeight:FontWeight.w800)),
                ],
              ),
            ),
            Divider(thickness: 2,),

            SizedBox(height:80),
            ElevatedButton(
              onPressed: () async{

                inspectorController.sendCreditRequest();
              },
              child: const Text(
                "Send",
                style: TextStyle(
                    fontSize: 17,
                    letterSpacing: 1
                ),
              ),
              style: ElevatedButton.styleFrom(

                  maximumSize: Size(Get.size.width -90,Get.size.width -90),
                  minimumSize: Size(Get.size.width -90, 40),primary: routes_color2,
                  onPrimary: Colors.white,
                  alignment: Alignment.center
              ),
            ),

          ],
        ),
      ),

    );
  }
}
