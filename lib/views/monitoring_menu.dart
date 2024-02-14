import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/Routes/routes.dart';
import 'package:my_app/components/app_bar.dart';
import 'package:my_app/components/box_menu.dart';
import 'package:my_app/viewmodels/monitoring_viewmodel.dart';
import 'package:my_app/viewmodels/wifi_viewmodel.dart';
import 'package:provider/provider.dart';

class MonitoringMenu extends StatefulWidget {
  final WifiViewModel wifiViewModel;
  const MonitoringMenu({super.key, required this.wifiViewModel});

  @override
  State<MonitoringMenu> createState() => _MonitoringMenuState();
}

class _MonitoringMenuState extends State<MonitoringMenu> {
  Set<IconData> icons = {};
  Set<String> names = {};
  Map<String, Map<String, dynamic>> modulesMap = {
    'A': {'icon': Icons.abc, 'name': 'M1 Input'},
    'B': {'icon': Icons.access_alarm, 'name': 'M1B Input'},
    'C': {'icon': Icons.accessibility, 'name': 'M2 Output'},
    'X': {'icon': Icons.add_box, 'name': 'M3 SUT'},
  };


  @override
  void initState(){     
      String modules = widget.wifiViewModel.modules;
      log(modules);
      names.clear();
      icons.clear();

      for (var element in modules.split('')) {
        if (modulesMap.containsKey(element)){
          names.add(modulesMap[element]?['name']);
          icons.add(modulesMap[element]?['icon']);
        }
      }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WifiViewModel>(
      builder: (context, wifiViewModel, _){
        return Scaffold(
        appBar: const AppBarCustom(tittle: 'Monitoring'),
        body: GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 2.5,
          mainAxisSpacing: 30,
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          
          children: List.generate(names.length, (index) {
            return GestureDetector(
              // borderRadius: BorderRadius.circular(20),
              onTap: (){
                Provider.of<MonitoringViewModel>(context, listen:false).setIsTimerActive(false);
                Navigator.pushNamed(context, RouteManager.monitoring, arguments: {names.elementAt(index)});
              },
              child: BoxMenu(
                icon: icons.elementAt(index),
                tittleBox:  names.elementAt(index),
                margins: const EdgeInsets.only(left:60, right: 60),
              )
              
            );
          }),
        ),
      );
      },
      
    );
  }
}