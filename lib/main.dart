import 'package:dine/Views/MenuPage/menuPage.dart';
import 'package:dine/Views/QrScannerPage/qrscannerPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dine',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Colors.white),
        // useMaterial3: true,
      ),
      home: const QrScanner(),
    );
  }
}
