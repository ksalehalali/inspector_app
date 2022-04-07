import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Inspector_Controllers/inspector_controller.dart';

class BusDetails extends StatefulWidget {
  const BusDetails({Key? key}) : super(key: key);

  @override
  _BusDetailsState createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
  final InspectorController inspectorController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(

      child: SafeArea(child:Scaffold(
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Center(
                      child: Text(
                        '${inspectorController.busScanned['company']}',
                        style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green[700],),
                      ),
                    ),
                    const SizedBox(
                      height: 22.0,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Bus plateNumber :',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      '${inspectorController.busScanned['palteNumber']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                    dividerDesign(),

                    const SizedBox(
                      height: 12.0,
                    ),
                    const Text(
                      'Kind :',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height:4.0,
                    ),
                    Text(
                      '${inspectorController.busScanned['kind']}',                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    dividerDesign(),

                    const SizedBox(
                      height: 12.0,
                    ),
                    const Text(
                      'Route :',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      '${inspectorController.busScanned['applicationRoute']['name_EN']}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    dividerDesign(),

                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'From To :',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      '${inspectorController.busScanned['applicationRoute']['from_To_EN']}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    dividerDesign(),

                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'active :',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      '${inspectorController.busScanned['active'].toString()}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    dividerDesign(),

                    const SizedBox(
                      height: 20.0,
                    ),

                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Today Passengers Count :',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      '${inspectorController.busScanned['palteNumber']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                    dividerDesign(),

                    const SizedBox(
                      height: 12.0,
                    ),
                    const Text(
                      'Existing Passengers Count :',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height:4.0,
                    ),
                    Text(
                      '${inspectorController.busScanned['kind']}',                      style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    dividerDesign(),

                    // Center(
                    //     child: Icon(
                    //       Icons.done,
                    //       size: 66,
                    //       color: Colors.green[800],
                    //     )),
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: FlatButton(
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //     child: Text('Close'),
                    //   ),
                    // )
                  ],
                ))
          ],
        ),
      )),
    );
  }
  Widget dividerDesign(){
    return const Divider(thickness: 2,);
  }
}
