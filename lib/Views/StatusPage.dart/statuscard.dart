import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dine/Views/CheckoutPage/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/orders.dart';
import '../../Models/restaurantMenu.dart';

class StatusCard extends StatelessWidget {
  StatusCard({super.key, required this.order});
  Orders? order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          boxShadow: const [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 4,
              color: Color.fromARGB(108, 0, 0, 0),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                          child: Row(
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
                                      text: '${order?.orderNo ?? ""}',
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
                                color: const Color(0xFF241C43),
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
                                      color: Color(0xFF241C43),
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
                                  color: ((order?.orderStatus ?? "") ==
                                              "Order Delivered" ||
                                          (order?.orderStatus ?? "") ==
                                              "Order Paid")
                                      ? Color(0xFF241C43)
                                      : Colors.white,
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
                                      child: Icon(
                                        Icons.room_service_outlined,
                                        color: ((order?.orderStatus ?? "") ==
                                                    "Order Delivered" ||
                                                (order?.orderStatus ?? "") ==
                                                    "Order Paid")
                                            ? Colors.white
                                            : Color(0xFF241C43),
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
                                  color: ((order?.orderStatus ?? "") ==
                                          "Order Paid")
                                      ? Color(0xFF241C43)
                                      : Colors.white,
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
                                      child: Icon(
                                        Icons.attach_money,
                                        size: 18,
                                        color: ((order?.orderStatus ?? "") ==
                                                "Order Paid")
                                            ? Colors.white
                                            : Color(0xFF241C43),
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
                  SizedBox(
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
                                  // text: '21',
                                  text: order?.tableNo.toString(),
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
                          width: 100,
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
                                  // text: 'Order Paid',
                                  text: order?.orderStatus,
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
            ...List.generate(order?.items?.length ?? 0, (index) {
              Map<String, int> temp = {};
              temp[order?.items?[index].name ?? ""] = 0;
              return CartItem(
                quantity: temp,
                image: order?.items?[index].image,
                itemButton: false,
                name: order?.items?[index].name,
                price: order?.items?[index].price,
                menu: order?.items?[index],
              );
            }),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
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
                                // text: '512 AED',
                                text: ' ${order?.price ?? ""} AED\n',
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
                                // text: '3 AED',
                                text: '${order?.tax ?? 0} AED\n',
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
                                text:
                                    // ' AED',
                                    '${order?.discount} AED\n',
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
                                // text: '402 AED',
                                text: '${order?.totalPrice ?? 0} AED',
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
            Row(
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
                                      // text: 'Mr Lelouch',
                                      text: '${order?.customerName ?? ""}\n',
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
                                      // text: '1234567890',
                                      text: '${order?.contactNo}',
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
        ),
      ),
    );
  }
}
