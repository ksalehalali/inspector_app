import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../Inspector_Controllers/globals.dart';
import '../../Inspector_Controllers/payment_controller.dart';
import 'balance_calculator.dart';


class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final PaymentController walletController = Get.find();
  int navIndex = 2;
  final box = GetStorage();
  bool? thereIsCard = false;
  var wallet;
  Color? _color = routes_color;
  Color? _color2 = Colors.grey[700];
  bool showPayments =true;
  bool showRecharges = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData()async{
     walletController.getMyWallet();
      walletController.getMyListOfRecharges();
      walletController.getMyListOfPayments();
  }

  @override
  Widget build(BuildContext context) {


    final screenSize = Get.size;
    return Scaffold(
      backgroundColor: Colors.blue[50]!.withOpacity(0.5),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * .1 - 70,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Available Balance',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Obx(
                        () => walletController.gotMyBalance.value == true
                            ? Text(
                                walletController.myBalance.value,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )
                            : const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.black,
                                  strokeWidth: 3,
                                )),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BalanceCalculator(chargeAmount: true,)));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_box_sharp,
                          color: Colors.green[900],
                          size: 28,
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          'Add Credit',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.1 - 22,
              ),

              SizedBox(
                height: 12.0,
              ),
              //trans3131

              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                _color = routes_color;
                                _color2 = Colors.grey[700];
                                showPayments =true;
                                showRecharges =false;

                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(duration: 11.seconds,
                                    curve: Curves.easeIn,
                                    child: Text('Payments',style: TextStyle(color: _color,fontWeight: FontWeight.w600))),
                                SizedBox(height: 10.0,),
                                AnimatedContainer(
                                  curve: Curves.easeInOut,
                                  width:screenSize.width/2-15,
                                  height: 2.5,
                                  color: _color,
                                  duration: 900.milliseconds ,

                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                _color2 = routes_color;
                                _color = Colors.grey[700];
                                showPayments =false;
                                showRecharges =true;
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                    curve: Curves.easeIn,
                                    duration: 14.seconds,

                                    child: Text('Recharges',style: TextStyle(color: _color2,fontWeight: FontWeight.w600),)),
                                SizedBox(height: 10.0,),
                                AnimatedContainer(
                                  curve: Curves.easeInOut,
                                  width: screenSize.width/2-15,
                                  height: 2.5,
                                  color: _color2,
                                  duration: 900.milliseconds ,

                                )
                              ],
                            ),
                          )
                        ],
                      ),

                      SizedBox(
                        height: screenSize.height * 0.1 - 62,
                      ),
                       Obx(()=> (walletController.gotPayments.value ==false&&walletController.gotRecharges.value==false)?Center(child: Image.asset('assets/images/Logo animated-loop-fast.gif',fit: BoxFit.fill,color: routes_color,),):Container()),
                      showPayments?SizedBox(
                        height: screenSize.height-200,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 122.0),
                          child: CustomScrollView(
                            slivers: [
                              Obx(()=> SliverList(delegate: SliverChildBuilderDelegate((context,index){
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text('route ${walletController.payments[index].routeName.toString()}',style: TextStyle(color: Colors.black),),
                                        subtitle:  Text(DateFormat('yyyy-MM-dd  HH:mm :ss').format(DateTime.parse(walletController.payments[index].date!)),style: TextStyle(height: 2),),
                                        trailing:  Text(walletController.payments[index].value!.toStringAsFixed(3),style: TextStyle(color:Colors.red,fontWeight: FontWeight.w600),),
                                        onTap: (){

                                        },
                                      ),
                                      Divider(thickness: 1,height: 10,),
                                    ],
                                  );
                                },childCount:walletController.payments.length ),),
                              )
                            ],
                          ),
                        )

                      ):Container(),

                      showRecharges?SizedBox(
                          height: screenSize.height-200,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 122.0),
                            child: CustomScrollView(
                              slivers: [
                                Obx(()=> SliverList(delegate: SliverChildBuilderDelegate((context,index){
                                  // print( DateFormat('yyyy-MM-dd-HH:mm').format(walletController.allTrans[0].time as DateTime));
                                  //final sortedCars = walletController.allTrans..sort((a, b) => a.time!.compareTo(b.time!));
                                  //print(sortedCars);
                                  return Column(
                                    children: [
                                      ListTile(
                                        //leading: Icon(Icons.payments_outlined),
                                        title: Text(walletController.recharges[index].paymentGateway.toString(),style: TextStyle(color: Colors.black),),
                                        subtitle:  Text(DateFormat('yyyy-MM-dd  HH:mm :ss').format(DateTime.parse(walletController.recharges[index].createdDate!)),style: TextStyle(height: 2),),
                                        trailing:  Text(walletController.recharges[index].invoiceValue!.toStringAsFixed(3),style: TextStyle(color:routes_color,fontWeight: FontWeight.w600),),
                                      ),
                                      Divider(thickness: 1,height: 10,)
                                    ],
                                  );
                                },childCount:walletController.recharges.length ),),
                                )
                              ],
                            ),
                          )

                      ):Container(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: screenSize.width - 20,
                        height: 2,
                        color: Colors.grey[300],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
