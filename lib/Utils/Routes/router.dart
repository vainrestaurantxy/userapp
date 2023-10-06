import 'package:dine/Utils/Constants/staticConstants.dart';
import 'package:dine/Views/CheckoutPage/checkout3.dart';
import 'package:dine/Views/MenuPage/menuPage.dart';
import 'package:dine/Views/StatusPage.dart/statusPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../Views/CheckoutPage/checkoutPage1.dart';
import '../../Views/CheckoutPage/checkoutPage2.dart';
import '../../Views/QrScannerPage/qrscannerPage.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const QrScanner();
      },
      routes: <RouteBase>[
        GoRoute(
            path: 'menu/:id',
            builder: (BuildContext context, GoRouterState state) {
              return MenuPage(
                id: state.pathParameters["id"]!,
              );
            },
            routes: <RouteBase>[
              GoRoute(
                  path: 'table/:no',
                  redirect: (context, state) {
                    Constants.tableNo =
                        int.parse(state.pathParameters['no'] ?? "0");
                    return '/menu/${state.pathParameters['id']}';
                  },
                  builder: (BuildContext context, GoRouterState state) {
                    return MenuPage(
                      id: state.pathParameters["id"]!,
                    );
                  }),
              GoRoute(
                  path: 'checkout',
                  builder: (BuildContext context, GoRouterState state) {
                    return const CheckoutPage();
                  },
                  routes: <RouteBase>[
                    GoRoute(
                        path: 'checkout2',
                        builder: (BuildContext context, GoRouterState state) {
                          return const CheckoutCartPage();
                        },
                        routes: <RouteBase>[
                          GoRoute(
                              path: 'checkout3',
                              builder:
                                  (BuildContext context, GoRouterState state) {
                                return ConfirmOrder();
                              },
                              routes: const <RouteBase>[]),
                        ]),
                  ]),
              GoRoute(
                path: 'status',
                builder: (BuildContext context, GoRouterState state) {
                  return Status();
                },
              )
            ]),
      ],
    ),
  ],
);
