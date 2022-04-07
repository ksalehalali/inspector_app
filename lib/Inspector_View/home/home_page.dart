
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Inspector_Controllers/consts.dart';
import '../../Inspector_Controllers/globals.dart';
import '../../Inspector_Controllers/inspector_controller.dart';
import 'widgets/QRCodeScanner.dart';
import 'widgets/list_flights.dart';
import 'widgets/search_results.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  initState() {
    super.initState();
    _tabController = TabController(length: homeTabs.length, vsync: this);
    _tabController!.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      tabIndex = _tabController!.index;
    });
  }

  @override
  dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  bool searchSelected = false;
  TabController? _tabController;
  int tabIndex = 0;
  bool changeFromTo = false;

  List<Tab> homeTabs = [
    const Tab(text: 'Actions'),
    const Tab(text: 'Buses Checked'),
  ];
  final InspectorController inspectorController = Get.find();
  var scanType='';
  @override
  Widget build(BuildContext context) {
    List<Widget> tabViews = [
      Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async{
                  scanType = 'Bus';

                  inspectorController.openCam.value =true;
                },
                child: const Text(
                  "Scan Bus",
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
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () async{
                  scanType = 'Ticket';
                  inspectorController.openCam.value =true;

                },
                child: const Text(
                  "Scan Ticket",
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
              SizedBox(height: 30,),

              ElevatedButton(
                onPressed: () async{

                },
                child: const Text(
                  "Send money",
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
      ),
      Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(child: searchSelected ? SearchResults() : ListFlights()),
          ],
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: routes_color,
      body: Padding(
        padding: const EdgeInsets.only(top: 42),
        child: Obx(()=>Stack(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [

                          routes_color4,
                          routes_color,
                        ]
                        )
                        ,
                        color: Colors.white
                    ),
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: tabViews,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(11.0),
                      height: (MediaQuery.of(context).size.height * 0.25) - 42,
                      child: Stack(
                        children: [

                          Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                         DelayedDisplay(
                                              child: Text(
                                                'WELCOME INSPECTOR  KHALED',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  !searchSelected
                                      ? Container(
                                          width: 1,
                                          height: 32,
                                          color: Colors.white.withOpacity(0.4),
                                        )
                                      : Container(),
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                          searchSelected
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 14),
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          changeFromTo = !changeFromTo;
                                        });
                                      },
                                      child: const Center(
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Icon(
                                            Icons.compare_arrows_sharp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    searchSelected
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                  )
                                ],
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: Icon(
                                    Icons.filter_alt_outlined,
                                    color: veppoBlue,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.fromLTRB(11, 0, 11, 0),
                            height: 52,
                            child: Stack(
                              children: [
                                Container(
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(28),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                      )
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  height: 44,
                                  width: (MediaQuery.of(context).size.width / 2) -
                                      26,
                                  margin: EdgeInsets.fromLTRB(
                                      tabIndex == 1
                                          ? (MediaQuery.of(context).size.width /
                                                  2) -
                                              26
                                          : 4,
                                      4,
                                      tabIndex == 4
                                          ? (MediaQuery.of(context).size.width /
                                                  2) -
                                              26
                                          : 4,
                                      4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(24),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 52,
                                  width: MediaQuery.of(context).size.width,
                                  child: TabBar(
                                    labelColor: veppoBlue,
                                    unselectedLabelColor: veppoLightGrey,
                                    indicatorColor: Colors.transparent,
                                    controller: _tabController,
                                    onTap: (index) {
                                      setState(() {
                                        tabIndex = index;
                                      });
                                    },
                                    tabs: homeTabs,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Spacer(),
                    _tabController!.index == 1
                        ? DelayedDisplay(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    searchSelected = !searchSelected;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.pressed))
                                        return veppoLightGrey;
                                      return routes_color;
                                    },
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 16, 0, 16),
                                  child: Text(
                                    searchSelected ? 'Back' : 'Search',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              inspectorController.openCam.value ==true? QRScanner(scanType: scanType,):Container(),

            ],
          ),
        ),
      ),
    );
  }
}
