import 'package:flutter/material.dart';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:inspector_app/Inspector_View/wallet/payment_method_dialog.dart';
import 'package:intl/intl.dart';
import 'package:myfatoorah_flutter/model/initsession/SDKInitSessionResponse.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import '../../Inspector_Controllers/current_data.dart';


const Color colorDark = Color(0xFF374352);
const Color colorLight = Color(0xFFe6eeff);

class BalanceCalculator extends StatefulWidget {
  @override
  _BalanceCalculatorState createState() => _BalanceCalculatorState();
}

class _BalanceCalculatorState extends State<BalanceCalculator> {
  bool darkMode = false;
  String val = "";
  double valDouble = 0.0;
  bool isDouble = false;
  int secondNumEntered = 0;
  bool isFirstNum = true;
  num amount = 00.000;
  var a ='KWD 0.000';
  var hint ='';
  List<String> ch =[];
  bool inputEnable =true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initiateSession();
    if(Get.isDarkMode){
      setState(() {
        darkMode = true;
      });
    }

  }

  checkLocalMode(){
    if(MediaQuery.of(context).platformBrightness == Brightness.dark){
      setState(() {
        darkMode = true;
      });
    }else{
      setState(() {
        darkMode = false;
      });
    }
  }
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: null,
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }


  @override
  Widget build(BuildContext context) {
    checkLocalMode();

    return Scaffold(
      backgroundColor: darkMode ? colorDark : colorLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(padding: EdgeInsets.only(left: 18.0),child:  Align(
                          alignment: Alignment.centerLeft,
                          child:  RichText(text:TextSpan(style: TextStyle(fontWeight: FontWeight.bold),children: [
                            a.length>=5 ? TextSpan(text: a[4]==','?'.':a[4],style: TextStyle(color:isFirstNum? Colors.grey[600]: darkMode ?Colors.white: Colors.black,fontSize: 38)):TextSpan(text: "0",style: TextStyle(color: Colors.grey[600],fontSize: 38)),
                            a.length>=6?TextSpan(text: a[5]==','?'.':a[5],style: TextStyle(color:isFirstNum? Colors.grey[600]:darkMode ?Colors.white:Colors.black,fontSize: 38)):TextSpan(text: ".",style: TextStyle(color:isFirstNum? Colors.grey[600]:Colors.black,fontSize: 38)),
                            a.length<=5 ? TextSpan(text: '0',style: TextStyle(color: Colors.grey[600],fontSize: 38)):TextSpan(text: "",),

                            a.length>=7 ?TextSpan(text: a[6]==','?'.':a[6],style:TextStyle(color:isFirstNum? Colors.grey[600]: darkMode ? Colors.white : Colors.black,fontSize: 38)):TextSpan(text: "0",style: TextStyle(color: Colors.grey[600],fontSize: 38)),
                            a.length>=8?TextSpan(text: a[7],style: TextStyle(color:isFirstNum? Colors.grey[600]: darkMode ?Colors.white : Colors.black,fontSize: 38)):TextSpan(text: "0",style: TextStyle(color: Colors.grey[600],fontSize: 38)),
                            a.length>=9?TextSpan(text:  a[8],style: TextStyle(color:isFirstNum? Colors.grey[600]: darkMode ? Colors.white : Colors.black,fontSize: 38)):TextSpan(text: "",style: TextStyle(color: Colors.grey[600],fontSize: 38)),
                            a.length>=10?TextSpan(text:  a[9],style: TextStyle(color:isFirstNum? Colors.grey[600]:darkMode ? Colors.white : Colors.black,fontSize: 38)):TextSpan(text: "",style: TextStyle(color: Colors.grey[600],fontSize: 38)),
                            TextSpan(text: '  KD',style: TextStyle(color:darkMode? Colors.white : Colors.black,fontSize: 38)),

                          ]) )
                      ),),
                      Padding(padding: EdgeInsets.only(right: 18.0),child:  IconButton(
                          onPressed: () {
                            if (val.length > 0) {
                              setState(() {
                                int index = val.length;
                                val = val.replaceRange(index - 1, index, '');
                                if(val.length>0){
                                  amount = int.parse(val);
                                }
                                if(val.isEmpty){
                                  isFirstNum =true;
                                  amount =0;
                                  inputEnable =true;
                                }
                                if(a.length <=10 ){
                                  a = NumberFormat.currency(locale: 'ar-kw',decimalDigits: 0,symbol: "KWD").format(amount);
                                  print(a);
                                  print(a.length);
                                }
                                valDouble.ceil();
                              });
                            }
                          },
                          icon: Icon(
                            Icons.backspace_outlined,
                            size: 38,
                            color: darkMode ? Colors.white : Colors.black,
                          )),)
                    ],
                  ),
                  SizedBox(height: 16.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      customButton(btnVal: '1', isDelete: false, isSend: false),
                      customButton(btnVal: '2', isDelete: false, isSend: false),
                      customButton(btnVal: '3', isDelete: false, isSend: false),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      customButton(btnVal: '4', isDelete: false, isSend: false),
                      customButton(btnVal: '5', isDelete: false, isSend: false),
                      customButton(btnVal: '6', isDelete: false, isSend: false),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      customButton(btnVal: '7', isDelete: false, isSend: false),
                      customButton(btnVal: '8', isDelete: false, isSend: false),
                      customButton(btnVal: '9', isDelete: false, isSend: false),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      customButton(btnVal: '0', isDelete: false, isSend: false),
                      // customButton(btnVal: '.', isDelete: false, isSend: false),
                      customButton(
                          btnVal: 'Next', isDelete: false, isSend: true),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _switchMode() {
    return NeuContainer(
      darkMode: darkMode,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 70,
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            Icons.wb_sunny,
            color: darkMode ? Colors.grey : Colors.redAccent,
          ),
          Icon(
            Icons.nightlight_round,
            color: darkMode ? Colors.green : Colors.grey,
          ),
        ]),
      ),
    );
  }

  //
  int? firstNum;
  int? secondNum;
  String? textToDisplay;
  String? res;
  String? operation;

  Widget customButton(
      {String? btnVal,
        String? title,
        double padding = 19,
        IconData? icon,
        Color? iconColor,
        Color? textColor,
        bool? isDelete,
        required bool isSend}) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: (isSend && amount >= 100 )
                ? Colors.green
                : isSend
                ? Colors.grey[600]
                : null,
            side: BorderSide(
                color: darkMode ? Colors.white : Colors.black, width: 0.1)),
        onPressed: () {
          if(isSend==true&&isDelete==false && amount >= 100){
            chargeSaved.invoiceValue = amount.toDouble()/1000;
            //go payment
            showD(context);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>CreditCardScreen(isPay: true,)));

            return;
          }else if(isSend==true&&isDelete==false && amount >= 100 ){
            if(!Get.isSnackbarOpen){
              Get.snackbar(
                  "Invalid Value", "Please Choose Your Vehicle",
                  colorText: Colors.red,
                  duration: Duration(seconds: 2));
            }
          }else if(isSend ==true && amount <100){
            return;
          }
          if(inputEnable){
            if(val.length<10){
              val = val +btnVal!;
              valDouble = double.parse(val);
              amount =int.parse(val);
              a = NumberFormat.currency(locale: 'ar',decimalDigits: 0,symbol: "KWD").format(amount);
              isFirstNum =false;
              if(a.length <=10 ){
                setState(() {
                  if (a.length ==5) {
                    ch.add(a[4]);
                    hint ='.000';
                  }  else if(a.length ==6){
                    ch.add(a[5]);
                    hint ='.000';
                  }else if(a.length ==7){
                    ch.add(a[6],);
                    hint ='.00';
                  }else if(a.length ==8){
                    ch.add(a[7]);
                    hint ='00';
                  }
                  else if(a.length ==9){
                    ch.add(a[8],);
                    hint ='0';
                  }
                  else if(a.length ==10){
                    ch.add(a[9],);
                    hint ='';
                  }
                  //payment.amount =amount.toDouble()/1000;
                  print(a);
                  if(a.length ==10){
                    inputEnable = false;
                  }
                  print("string length ::${a.length}");
                  amount =int.parse(val);
                });
                print(ch);

              }
            }else{
              return;
            }

          }


        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 26.0),
          child: Text(
            btnVal!,
            style: TextStyle(
                fontSize: 28.0, color: darkMode ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
//

  String _response = '';
  late MFPaymentCardView mfPaymentCardView;
  void initiateSession() {

    MFSDK.initiateSession((MFResult<MFInitiateSessionResponse> result) => {
      if (result.isSuccess())
        {
          mfPaymentCardView.load(result.response!)}
      else
        {
          setState(() {
            print("Response: " +
                result.error!.toJson().toString().toString());
            _response = result.error!.message!;
          })
        }
    });
  }
}

class NeuContainer extends StatefulWidget {
  final bool darkMode;
  final Widget? child;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  NeuContainer(
      {this.darkMode = false, this.child, this.borderRadius, this.padding});

  @override
  _NeuContainerState createState() => _NeuContainerState();
}

class _NeuContainerState extends State<NeuContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.darkMode;
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
            color: darkMode ? colorDark : colorLight,
            borderRadius: widget.borderRadius,
            boxShadow: _isPressed
                ? null
                : [
              BoxShadow(
                color:
                darkMode ? Colors.black54 : Colors.blueGrey.shade200,
                offset: Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                  color:
                  darkMode ? Colors.blueGrey.shade700 : Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0)
            ]),
        child: widget.child,
      ),
    );
  }
}
