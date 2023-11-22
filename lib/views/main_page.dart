import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';
import 'package:my_app/Routes/routes.dart';
import 'package:my_app/components/app_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      appBar: AppBarCustom(tittle: 'Smart Guardian P3S'),
      backgroundColor: AppColors.mainColor,

      body: Options(),
    );
  }
}

class Options extends StatelessWidget {
  const Options({super.key});

  static final List<IconData> _icons= [Icons.wifi, Icons.monitor_rounded, Icons.usb];
  static final List<String> _textIcons = ['Wifi Settings', 'Monitoring', 'USB Download'];

  @override
  Widget build(BuildContext context){
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(3, (index) {
        return InkWell(
          borderRadius: BorderRadius.circular(20),
          
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.secondColor, 
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(_icons[index], size: 60),
                Text(
                  _textIcons[index], 
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, RouteManager.wifiSetting);   
          },  
        );
      }),
    );
  }
}