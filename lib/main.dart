import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inspector_app/Inspector_Controllers/inspector_controller.dart';

import 'Inspector_View/home/home_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final paymentController =Get.putAsync(() async => InspectorController(),permanent: true);

  await GetStorage.init();

  runApp( GetMaterialApp(
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home:  MyApp()
  ),);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return   const HomePage();
  }
}
