import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';
import 'package:my_app/Routes/routes.dart';
import 'package:my_app/Screens/wifi_settings.dart';
import 'Screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.mainColor,
      ),
      // home: const MainPage(),
      initialRoute: RouteManager.home,
      routes: {
        RouteManager.home         : (context) => const MainPage(),
        RouteManager.wifiSetting  : (context) => const WifiSettings(), 
        RouteManager.monitoring   : (context) => const WifiSettings(),
      },
    );
  }
}
