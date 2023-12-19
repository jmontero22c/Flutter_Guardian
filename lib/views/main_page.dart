import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';
import 'package:my_app/Routes/routes.dart';
import 'package:my_app/components/app_bar.dart';
import 'package:my_app/components/box_menu.dart';
import 'package:my_app/viewmodels/wifi_viewmodel.dart';
import 'package:provider/provider.dart';

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

  // static final List<IconData> _icons= [Icons.wifi, Icons.monitor_rounded, Icons.usb];
  // static final List<String> _textIcons = ['Wifi Settings', 'Monitoring', 'USB Download'];

  static final Map<int,Map<String,dynamic>> buttonsPage = {
    0 : {
      'text':'Wifi Settings',
      'icon':Icons.wifi,
      'route':RouteManager.wifiSetting
    },
    1 : {
      'text':'Monitoring',
      'icon':Icons.monitor_rounded,
      'route':RouteManager.monitoringMenu
    },
    2 : {
      'text':'USB Download',
      'icon':Icons.monitor_rounded,
      'route':RouteManager.wifiSetting
    }
  };

  @override
  Widget build(BuildContext context){
    WifiViewModel wifiViewModel = Provider.of<WifiViewModel>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              color: AppColors.secondColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondColor.withOpacity(0.4), //Color(0xFF3A5160).withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0
                )
              ],
              borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
            ),
            height: 185,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(  
                    children: [
                      
                      //TEXTO STATUS MAIN
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                'NAME DEVICE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.grey
                                  ),
                              ),
                              
                            ),
                            Row(
                              children: [
                                SizedBox(width: 20, height: 20, child: Image.asset('assets/info.jpg'),),
                                const SizedBox(width: 10),
                                Text(
                                  wifiViewModel.wifiStatus ? wifiViewModel.wifiName : '----',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                  ),
                                ),
                              ],
                            ),
                          ]
                        ),
                      ),
    
                      //==================================WIFI STATUS MAIN=====================================//
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                'STATUS',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.grey
                                  ),
                              ),
                              
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 25,
                                  color: wifiViewModel.wifiStatus ? Colors.green : Colors.red,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  wifiViewModel.wifiStatus ? 'ON' : 'OFF',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                  ),
                                ),
                              ],
                            ),
                          ]
                        ),
                      ),
    
                      //==================================CPU VERSION=====================================//
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                'NAME DEVICE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.grey
                                  ),
                              ),
                              
                            ),
                            Row(
                              children: [
                                SizedBox(width: 25, height: 25, child: Image.asset('assets/cpu.jpg'),),
                                const SizedBox(width: 10),
                                Text(
                                  wifiViewModel.wifiStatus ? wifiViewModel.versionCPU.toString() : '----',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                  ),
                                ),
                              ],
                            ),
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30, right: 15, left: 15 ),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/Logo_Guardian.jpg',
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
        ),
        
        //Grid con los botones de las diferentes pantallas
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            mainAxisSpacing: 20,
            children: List.generate(buttonsPage.length, (index) {
              return GestureDetector(  
                child: BoxMenu(
                  icon: buttonsPage[index]!['icon'],
                  tittleBox:  buttonsPage[index]!['text'],
                  margins: const EdgeInsets.only(left: 20, right: 20)
                ), 
                onTap: () {
                  Navigator.pushNamed(context, buttonsPage[index]!['route']);   
                },  
              );
            }),
          ),
        ),
      ]
    );
  }
}