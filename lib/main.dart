import 'package:dine/Views/MenuPage/menuPage.dart';
import 'package:dine/Views/QrScannerPage/qrscannerPage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dine',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Colors.white),
        // useMaterial3: true,
      ),
      home: const QrScanner(),
    );
  }
}
