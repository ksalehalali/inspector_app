
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../Inspector_Controllers/globals.dart';
import '../../Inspector_Controllers/inspector_controller.dart';
import '../../Inspector_Controllers/payment_controller.dart';

class YourActivitiesScreen extends StatefulWidget {
  const YourActivitiesScreen({Key? key}) : super(key: key);

  @override
  _YourActivitiesScreenState createState() => _YourActivitiesScreenState();
}

class _YourActivitiesScreenState extends State<YourActivitiesScreen> {
  final PaymentController walletController = Get.find();
  final InspectorController inspectorController = Get.find();

  final screenSize = Get.size;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inspectorController.getInspectorBusesChecked();
    inspectorController.getTicketsChecked();

  }
  int navIndex = 2;
  final box = GetStorage();
  bool? thereIsCard = false;
  var wallet;
  Color? _color = routes_color;
  Color? _color2 = Colors.grey[700];
  bool showBusesChecked =true;
  bool showTicketsChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back,color: Colors.blue[900],size: 32,),
        ),
        title: Text('Your Activities',style: TextStyle(color: Colors.blue[900]),),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // Row(
             //   crossAxisAlignment: CrossAxisAlignment.start,
             //   children: [
             //     Padding(
             //            padding: const EdgeInsets.all(8.0),
             //            child: Text('History',style: TextStyle(color: Colors.blue[900],fontSize: 16,fontWeight: FontWeight.bold),),
             //          ),
             //     Spacer(),
             //     Padding(
             //       padding: const EdgeInsets.all(8.0),
             //       child: Obx(()=>Text('${walletController.totalOfMyPayments.value}',style: TextStyle(color: Colors.blue[900],fontSize: 16,fontWeight: FontWeight.bold),)),
             //     ),
             //   ],
             // ),
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
                                showBusesChecked =true;
                                showTicketsChecked =false;

                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(duration: 11.seconds,
                                    curve: Curves.easeIn,
                                    child: Text('Buses Scanned',style: TextStyle(color: _color,fontWeight: FontWeight.w600))),
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
                                showBusesChecked =false;
                                showTicketsChecked =true;
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                    curve: Curves.easeIn,
                                    duration: 14.seconds,

                                    child: Text('Tickets Scanned',style: TextStyle(color: _color2,fontWeight: FontWeight.w600),)),
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
                      Obx(()=> (inspectorController.gotBusesChecked.value==false)?Center(child: Image.asset('assets/images/Logo animated-loop-fast.gif',fit: BoxFit.fill,color: routes_color,),):Container()),
                      showBusesChecked?SizedBox(
                          height: screenSize.height-200,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 122.0),
                            child: CustomScrollView(
                              slivers: [
                                Obx(()=> SliverList(delegate: SliverChildBuilderDelegate((context,index){
                                  return Column(
                                    children: [
                                      ListTile(
                                  leading:Text('${index+1}',style: TextStyle(color: Colors.black,fontSize: 16),),
                                        title: Text('${inspectorController.inspectorBusesChecked.value[index]['company']}',style: TextStyle(color: Colors.black),),
                                        subtitle:  Text("Plate Number : ${inspectorController.inspectorBusesChecked[index]['palteNumber']}",style: TextStyle(height: 2),),
                                        trailing:  Text("Route : ${inspectorController.inspectorBusesChecked[index]['route']}",style: TextStyle(color:Colors.red,fontWeight: FontWeight.w600),),
                                        onTap: (){

                                        },
                                      ),
                                      Divider(thickness: 1,height: 10,),
                                    ],
                                  );
                                },childCount:inspectorController.inspectorBusesChecked.length ),),
                                )
                              ],
                            ),
                          )

                      ):Container(),

                      showTicketsChecked?SizedBox(
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
                                        leading:Text('${index+1}',style: TextStyle(color: Colors.black,fontSize: 16),),
                                        title: Text(inspectorController.inspectorTicketsChecked.value[index]['name'].toString(),style: TextStyle(color: Colors.black),),
                                        //subtitle:  Text(DateFormat('yyyy-MM-dd  HH:mm :ss').format(DateTime.parse(walletController.recharges[index].createdDate!)),style: TextStyle(height: 2),),
                                  subtitle:Text(inspectorController.inspectorTicketsChecked.value[index]['userID'],style: TextStyle(color:routes_color,fontWeight: FontWeight.w600,fontSize:11),),
                                  trailing:  Text(inspectorController.inspectorTicketsChecked.value[index]['phone'],style: TextStyle(color:routes_color,fontWeight: FontWeight.w600),),
                                      ),
                                      Divider(thickness: 1,height: 10,)
                                    ],
                                  );
                                },childCount:inspectorController.inspectorTicketsChecked.length ),),
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
