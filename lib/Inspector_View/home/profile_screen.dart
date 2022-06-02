
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspector_app/Inspector_View/home/personal_information.dart';
import 'package:inspector_app/Inspector_View/home/widgets/headerDesgin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Inspector_Controllers/globals.dart';
import '../../Inspector_Controllers/personal_information_controller.dart';
import '../wallet/your_activities.dart';
import '../your_activities_screen.dart';


class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final personalInfoController = Get.put(PersonalInformationController());

  @override
  Widget build(BuildContext context) {
    final screenSize = Get.size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [

          routes_color6,
          routes_color,
        ]
        )
      ),
      child: SafeArea(
        child: Scaffold(

            body: Stack(
              children: [
                Positioned(
                    top: 0.0,
                    child: SizedBox(
                        height: screenSize.height*0.1+11,
                        width: screenSize.width,
                        child: Header(screenSize))),
                Positioned(
                  top: 84 ,
                  child: SizedBox(
                    height: screenSize.height,
                    width: screenSize.width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenSize.height * 0.1 - 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Your Account',
                                  style:TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.grey[800]),

                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(()=> PersonalInformation());
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_pin,
                                        size: 32,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        'Personal Information',
                                        style:TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.grey[600]),

                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 22,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),


                              SizedBox(
                                height: 10.0,
                              ),
                              InkWell(
                                onTap: (){
                                  Get.to(()=>YourActivitiesScreen());

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.watch_later_outlined,
                                        size: 32,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        'Your activities',
                                        style:TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.grey[600]),

                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 22,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                      SizedBox(
                      height: screenSize.height * 0.1 - 56,
                      ),
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Get support',
                            style:TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.grey[800]),

                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              //Get.to(()=> const HelpScreen());
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.help_center_outlined,
                                  size: 32,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  'Help',
                                  style:TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.grey[600]),

                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 22,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),

                          SizedBox(
                            height: screenSize.height * 0.1 - 58,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              const SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                height: 2,
                                width: screenSize.width - 20,
                                color: Colors.grey[200],
                              ),
                              SizedBox(
                                height: 22.0,
                              ),
                              Center(
                                  child: ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.logout,
                                      size: 32,
                                      color: Colors.red,
                                    ),
                                    onPressed: ()async {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      print(prefs.getString('token'));
                                      prefs.remove('token');
                                      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
                                    },
                                    label: Text('Log Out',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                                    style: ElevatedButton.styleFrom(
                                        maximumSize: Size(Get.size.width -220,Get.size.width -220),
                                        minimumSize: Size(Get.size.width -220, 40),primary: Colors.white,
                                        onPrimary: routes_color,
                                        alignment: Alignment.center
                                    ),)
                              ),
                              SizedBox(height: 22,),

                              Center(
                                child: InkWell(
                                  onTap: (){},
                                  child: Text('Terms and conditions',style: TextStyle(fontSize: 15,color: Colors.green[700]),),
                                ),
                              ),

                              const Divider(),


                            ],
                          )
                        ],
                      ),
                      ])),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}