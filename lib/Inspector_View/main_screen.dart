import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Inspector_Controllers/globals.dart';
import 'home/bus_details.dart';
import 'home/home_page.dart';
import 'wallet/wallet_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screens = [
    const HomePage(),
    const WalletScreen(),
    const BusDetails(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  int? currentTp = 0;
  @override
  Widget build(BuildContext context) {
    return Container(

        child:SafeArea(child: Scaffold(
    body: PageStorage(bucket: bucket, child: currentScreen,

    ),
        bottomNavigationBar: NavigationBar(
            height: 62.0,
            backgroundColor: Colors.white,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            selectedIndex: currentTp!,
            onDestinationSelected: (index) {
              setState(() {
                currentScreen = screens[index];
                currentTp = index;
              });
            },
            animationDuration: Duration(milliseconds: 1),
            destinations: [


              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 12))),
                  child: NavigationDestination(
//                    icon: Icon(Icons.home_outlined,color: Colors.blue[900]),
                    label: 'Home',
                    icon: SvgPicture.asset("${assetsDir}home_svg.svg", width: 20, color: Colors.grey[600],),
                    selectedIcon: SvgPicture.asset("${assetsDir}home_svg.svg", width: 25, color: Colors.blue[900],),
                  )),

              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 12))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset("${assetsDir}wallet.svg", width: 20, color: Colors.grey[600],),
                    label: 'Wallet',
                    selectedIcon: SvgPicture.asset("${assetsDir}wallet.svg", width: 25, color: Colors.blue[900],),
                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 12))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset("${assetsDir}profile.svg", width: 20, color: Colors.grey[600],),
                    label: 'Profile',
                    selectedIcon: SvgPicture.asset("${assetsDir}profile.svg", width: 25, color: Colors.blue[900],),
                  )),
            ])
    )));
  }
}
