import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';
import 'package:my_app/Routes/routes.dart';
import 'package:my_app/components/app_bar.dart';
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

  static final List<IconData> _icons= [Icons.wifi, Icons.monitor_rounded, Icons.usb];
  static final List<String> _textIcons = ['Wifi Settings', 'Monitoring', 'USB Download'];

  @override
  Widget build(BuildContext context){
    WifiViewModel wifiViewModel = Provider.of<WifiViewModel>(context);
    return Scrollbar(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
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
                      topRight: Radius.circular(68.0)),
              ),
              // height: 80,
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
                                      fontSize: 13,
                                      color: Colors.grey
                                    ),
                                ),
                                
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    wifiViewModel.wifiStatus ? wifiViewModel.wifiName : 'NONE',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ),
                        ),

                        //==================================TEXTO NOMBRE MAIN=====================================//
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
                                      fontSize: 13,
                                      color: Colors.grey
                                    ),
                                ),
                                
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 30,
                                    color: wifiViewModel.wifiStatus ? Colors.green : Colors.red,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    wifiViewModel.wifiStatus ? 'ON' : 'OFF',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ),
                        )
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
            ),
          ),
        ]
      ),
    );
  }
}