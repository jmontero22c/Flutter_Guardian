import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';
import 'package:my_app/Screens/wifi_settings.dart';
import 'Screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const List<String> routes = ['/', '/WifiSetting', '/monitoring'];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(routes);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        useMaterial3: true,
        scaffoldBackgroundColor: mainColor,
      ),
      // home: const MainPage(),
      initialRoute: routes[0],
      routes: {
        routes[0] : (context) {
          print("Building MainPage with routes: $routes");
          return MainPage(routes: routes);
        },
        routes[1] : (context) => const WifiSettings(), 
        routes[2] : (context) => const WifiSettings()
      },
    );
  }
}
