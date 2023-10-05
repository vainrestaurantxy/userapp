import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/ViewModels/CheckoutPageViewModel/checkoutPageViewModel.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'Utils/Routes/router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        // ListenableProvider<CheckoutViewModel>(
        //     create: (_) => CheckoutViewModel()),
        ListenableProvider<MenuPageViewModel>(
            create: (_) => MenuPageViewModel()),
        ListenableProvider<MenuPageData>(create: (_) => MenuPageData()),
        ListenableProvider<RestaurantBuilder>(
            create: (_) => RestaurantBuilder()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Dine',
      theme: ThemeData(colorScheme: const ColorScheme.light(primary: Color(0xFF8C8C8C)),
        // useMaterial3: true,
      ),
      // home: const QrScanner(),
    );
  }
}
