import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';
import 'package:my_app/components/app_bar.dart';
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
  
  // _MonitoringMenuState(WifiViewModel wifiViewModel);

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
              
              child: Container(
                margin: const EdgeInsets.only(left:60, right: 60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondColor, 
                ),
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(icons.elementAt(index), size: 50),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      height: 1,
                    ),
                    Text(
                      names.elementAt(index), 
                      style: const TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              
            );
          }),
        ),
      );
      },
      
    );
  }
}