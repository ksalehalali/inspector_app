import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../Inspector_Controllers/current_data.dart';
import '../../Inspector_Controllers/payment/check_out.dart';
import '../../Inspector_Controllers/payment/my_fatoorh_checkout.dart';


Future<void> showOptionsCardsDialog(context) async {
  final screenSize = MediaQuery.of(context).size;
  CheckOut checkOut = CheckOut();
  MyFatoorah myFatoorh = MyFatoorah();

  final String mAPIKey = "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";

  return await showDialog(
      context: context,
      builder: (context) {
        int? value = 1;
        double? kNetPos = 600;

        return StatefulBuilder(builder: (context, setState) {
          Timer(Duration(milliseconds: 2), () {
            setState(() {
              kNetPos = 290.0;
            });
          });
          return Container(
            width: screenSize.width,
            child: AlertDialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(top: 0.0),
              contentPadding: EdgeInsets.all(5),
              content: Center(
                child: SizedBox(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 3,
                          left: MediaQuery.of(context).size.width - 50,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.cancel_outlined),
                            color: Colors.blue.shade900,
                          )),

                      const SizedBox(
                        height: 50,
                      ),

                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        top: kNetPos,
                        child: SizedBox(
                          height: 700,
                          width: MediaQuery.of(context).size.width,
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade300),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        value = 1;
                                        print(value);

                                        myFatoorh.initiate(context, chargeSaved.invoiceValue!.toDouble(),1);

                                      });
                                    },
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 45.0, vertical: 5),
                                        child: Image.asset(
                                          'assets/images/knet_logo2.png',
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade300),
                                  child: InkWell(
                                    onTap: () {
                                      myFatoorh.initiate(context, chargeSaved.invoiceValue!.toDouble(),2);

                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             VisaMasterMethod()),
                                      // );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 45.0, vertical: 5),
                                      child: Image.asset(
                                        'assets/images/visaLogo2.png',
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100.0),
                                child: Container(
                                  width: screenSize.width - 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade300),
                                  child: InkWell(
                                    onTap: () {
                                        value = 1;
                                        print(value);
                                        myFatoorh.initiate(context, chargeSaved.invoiceValue!.toDouble(),2);

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 45.0, vertical: 5),
                                      child: Image.asset(
                                        'assets/images/masterCard_2.png',
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      });
}
