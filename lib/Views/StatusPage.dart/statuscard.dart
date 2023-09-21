import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 85,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 396,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFE7E7FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Order ID:',
                                  style: TextStyle(
                                    color: Color(0xFF323232),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ',
                                  style: TextStyle(
                                    color: Color(0xFF323232),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: '12',
                                  // order["orderNo"]!.toString(),
                                  style: TextStyle(
                                    color: Color(0xFF53389E),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(width: 139.w),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF554D68),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFF241D43)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 18,
                                height: 18,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF554D68),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          // onTap: (order["orderStatus"] ==
                          //             "Order Delivered" ||
                          //         order["orderStatus"] == "Order Paid")
                          //     ? null
                          //     : () async {
                          //         DocumentSnapshot<Map<String, dynamic>>
                          //             data = await FirebaseFirestore
                          //                 .instance
                          //                 .collection("Restaurants")
                          //                 .doc(FirebaseAuth
                          //                     .instance.currentUser!.uid)
                          //                 .collection("Orders")
                          //                 .doc(
                          //                     '${DateTime.now().toUtc().day}|${DateTime.now().toUtc().month}|${DateTime.now().toUtc().year}')
                          //                 .get();

                          //         Map<String, dynamic>? json = data.data();

                          //         json!["order"][index]["orderStatus"] =
                          //             "Order Delivered";

                          //         await FirebaseFirestore.instance
                          //             .collection("Restaurants")
                          //             .doc(FirebaseAuth
                          //                 .instance.currentUser!.uid)
                          //             .collection("Orders")
                          //             .doc(
                          //                 '${DateTime.now().toUtc().day}|${DateTime.now().toUtc().month}|${DateTime.now().toUtc().year}')
                          //             .set(json);
                          //       },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: ShapeDecoration(
                              // color: (order["orderStatus"] ==
                              //             "Order Delivered" ||
                              //         order["orderStatus"] == "Order Paid")
                              //     ?
                              color: const Color(0xFFffffff),
                              // : Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFF241C43)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Icon(
                                    Icons.room_service_outlined,
                                    // color: (order["orderStatus"] ==
                                    //             "Order Delivered" ||
                                    //         order["orderStatus"] ==
                                    //             "Order Paid")
                                    //     ?
                                    color: Color(0xff554D68),
                                    // : Color(0xFF241C43),
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          // onTap: (order["orderStatus"] == "Order Paid")
                          //     ? null
                          //     : () async {
                          //         DocumentSnapshot<Map<String, dynamic>>
                          //             data = await FirebaseFirestore
                          //                 .instance
                          //                 .collection("Restaurants")
                          //                 .doc(FirebaseAuth
                          //                     .instance.currentUser!.uid)
                          //                 .collection("Orders")
                          //                 .doc(
                          //                     '${DateTime.now().toUtc().day}|${DateTime.now().toUtc().month}|${DateTime.now().toUtc().year}')
                          //                 .get();
                          //         Map<String, dynamic>? json = data.data();
                          //         json!["order"][index]["orderStatus"] =
                          //             "Order Paid";
                          //         print(json);
                          //         await FirebaseFirestore.instance
                          //             .collection("Restaurants")
                          //             .doc(FirebaseAuth
                          //                 .instance.currentUser!.uid)
                          //             .collection("Orders")
                          //             .doc(
                          //                 '${DateTime.now().toUtc().day}|${DateTime.now().toUtc().month}|${DateTime.now().toUtc().year}')
                          //             .set(json);
                          //       },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: ShapeDecoration(
                              color:
                                  //  (order["orderStatus"] == "Order Paid")
                                  const Color(0xFFffffff),
                              // : Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFF241C43)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Icon(Icons.attach_money,
                                      size: 18,
                                      color:

                                          // (order["orderStatus"] ==
                                          //         "Order Paid")
                                          Color(0xff554D68)
                                      // : Color(0xFF241C43),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const SizedBox(
                height: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Table Number: ',
                              style: TextStyle(
                                color: Color(0xFF3B3F5C),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: '21',
                              //  order["tableNo"].toString(),
                              style: TextStyle(
                                color: Color(0xFF53389E),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      width: 147,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Status:',
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'Order Paid',
                              //order["orderStatus"],
                              style: TextStyle(
                                color: Color(0xFF53389E),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                  // width: double.infinity,
                  child: Row(
                children: [
                  Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Image.asset(
                        'assets/burger.jpg',
                        height: 43,
                        width: 43,
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Burger',
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 160,
                          )
                        ],
                      ),
                      Container(
                        width: 200,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('AED 1400'), Text('qty: 2')],
                        ),
                      )
                    ],
                  )
                ],
              )),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: const Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Order Total:',
                        style: TextStyle(
                          color: Color(0xFF3B3F5C),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '512 AED',
                            //' ${order["price"]} AED\n',
                            style: TextStyle(
                              color: Color(0xFF3B3F5C),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ]),
                    TextSpan(
                        text: 'Tax (5%):',
                        style: TextStyle(
                          color: Color(0xFF3B3F5C),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '3 AED',
                            //' ${order["tax"]} AED\n',
                            style: TextStyle(
                              color: Color(0xFF3B3F5C),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ]),
                    TextSpan(
                        text: 'Discount :',
                        style: TextStyle(
                          color: Color(0xFF3B3F5C),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '110 AED', //' ${order["discount"]} AED\n',
                            style: TextStyle(
                              color: Color(0xFF3B3F5C),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ]),
                    TextSpan(
                        text: 'Total: ',
                        style: TextStyle(
                          color: Color(0xFF3B3F5C),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '402 AED',
                            // '${order["totalPrice"]} AED',
                            style: TextStyle(
                              color: Color(0xFF53389E),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ]),
                  ],
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 235,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Customer Name: ',
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Mr Lelouch',
                                  // '${order["customerName"]}\n',
                                  style: TextStyle(
                                    color: Color(0xFF53389E),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ]),
                          // TextSpan(
                          //   text: ' ',
                          //   style: TextStyle(
                          //     color: Color(0xFF323232),
                          //     fontSize: 12,
                          //     fontFamily: 'Poppins',
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),

                          TextSpan(
                              text: 'Customer Contact: ',
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: '1234567890',
                                  //'${order["contactNo"]}',
                                  style: TextStyle(
                                    color: Color(0xFF53389E),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ]),
                          // TextSpan(
                          //   text: ' ',
                          //   style: TextStyle(
                          //     color: Color(0xFF323232),
                          //     fontSize: 12,
                          //     fontFamily: 'Poppins',
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
      ],
    );
  }
}
