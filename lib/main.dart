import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/ViewModels/CheckoutPageViewModel/checkoutPageViewModel.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:provider/provider.dart' as prov;
import 'Utils/Routes/router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    prov.MultiProvider(
      providers: [
        // ListenableProvider<CheckoutViewModel>(
        //     create: (_) => CheckoutViewModel()),
        prov.ChangeNotifierProvider<MenuPageViewModel>(
            create: (_) => MenuPageViewModel()),
        prov.ChangeNotifierProvider<MenuPageData>(
            create: (_) => MenuPageData()),
        prov.ChangeNotifierProvider<RestaurantBuilder>(
            create: (_) => RestaurantBuilder()),
      ],
      child: ProviderScope(child: const MyApp()),
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
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Color(0xFF8C8C8C)),
        // useMaterial3: true,
      ),
      // home: const QrScanner(),
    );
  }
}
