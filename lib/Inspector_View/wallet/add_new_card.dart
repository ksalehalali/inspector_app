import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({Key? key}) : super(key: key);

  @override
  _AddNewCardScreenState createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  final box = GetStorage();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FocusScope.of(context).unfocus();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = Get.size;

    return Scaffold(
      backgroundColor: Colors.blue[50],

        appBar: AppBar(
          foregroundColor: Colors.blue[900],
          elevation: 0.0,
          leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.clear),
          ),
          title: Text(
            'Add Credit',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          color: Colors.blue[50],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 22.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.security_sharp,
                      size: 28,
                      color: Colors.blue[900],
                    ),
                    Text(
                      'Yor payment info is stored securely ',
                      style: TextStyle(color: Colors.grey[600]),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Padding(
                    padding: EdgeInsets.all(22.0),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: screenSize.width - 160,
                                child: Container(
                                  child:  CupertinoTextField(
                                    onChanged: (val) {
                                      if (val.length == 14) {
                                        setState(() {

                                        });
                                      }
                                    },
                                    placeholder: 'Card number',
                                    textAlign: TextAlign.left,
                                    placeholderStyle: TextStyle(fontSize: 16,color: Colors.grey,height: 1.5),

                                    autofocus: true,
                                    style: TextStyle(letterSpacing:5),
                                    //controller: otpTextEditingController,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    maxLength: 14,
                                    // autofillHints: <String>[AutofillHints.telephoneNumber],
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Icon(
                                Icons.payment_outlined,
                                size: 46.0,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(height: 22.0,),
                          Row(
                            children: [
                              SizedBox(
                                width: screenSize.width - 190,
                                child: Container(
                                  child:  CupertinoTextField(
                                    onChanged: (val) {
                                      if (val.length == 14) {
                                        setState(() {
                                          FocusScope.of(context).unfocus();
                                          print(val.length);
                                        });
                                      }
                                    },
                                    suffix: Icon(Icons.info_outline,color: Colors.grey,),
                                    placeholder: 'Expiry Date (mm/yy)',
                                    placeholderStyle: TextStyle(fontSize: 16,color: Colors.grey,height: 1.5),
                                    textAlign: TextAlign.left,
                                    autofocus: true,
                                    style: TextStyle(letterSpacing:0.5),
                                    //controller: otpTextEditingController,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    maxLength: 5,
                                    // autofillHints: <String>[AutofillHints.telephoneNumber],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              SizedBox(
                                width: screenSize.width - 308,
                                child: Container(
                                  child:  CupertinoTextField(
                                    onChanged: (val) {
                                      if (val.length == 14) {
                                        setState(() {
                                          FocusScope.of(context).unfocus();
                                          print(val.length);
                                        });
                                      }
                                    },
                                    placeholder: 'CVV',
                                    suffix: Icon(Icons.info_outline,color: Colors.grey,),
                                    placeholderStyle: TextStyle(fontSize: 16,color: Colors.grey,height: 1.5),

                                    textAlign: TextAlign.left,
                                    autofocus: true,
                                    style: TextStyle(letterSpacing:1),
                                    //controller: otpTextEditingController,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    maxLength: 3,
                                    // autofillHints: <String>[AutofillHints.telephoneNumber],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
