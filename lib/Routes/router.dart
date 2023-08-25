import 'package:dine/Views/MenuPage/menuPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Views/QrScannerPage/qrscannerPage.dart';

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
        ),
      ],
    ),
  ],
);
