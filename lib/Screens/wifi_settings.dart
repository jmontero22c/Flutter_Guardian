import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class WifiSettings extends StatefulWidget {
  const WifiSettings({super.key});

  @override
  State<WifiSettings> createState() => _WifiSettings();
}

class _WifiSettings extends State<WifiSettings> {
  final info = NetworkInfo();
  String nameWifi = '';
  String? wifiIP = 'IP PRUEBA';

  Future<void> connectWifi() async {
    var locationStatus = await Permission.location.status;

    print(locationStatus);
    if (locationStatus.isDenied){
      await Permission.locationWhenInUse.request();
    }
    if (await Permission.location.isRestricted) {
      openAppSettings();
    }
    if (await Permission.location.isGranted) 
    {
      var wifiName = await info.getWifiName();
      var _wifiIP = await info.getWifiIP();
      if (_wifiIP != null) {
        setState(() {
          nameWifi = wifiName??"NO NAME";
          wifiIP = _wifiIP;
        });
        print(nameWifi);
      } else {
        print('Not connected to a Wi-Fi network.');
      } 
    }
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        // backgroundColor: secondColor,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Wiffi Setting", style: TextStyle(color: mainColor),),
        iconTheme: const IconThemeData(color: mainColor),
      ),
      body: ListView(
        children: [
          Center(
            child: ElevatedButton(
              // style: style,
              onPressed: () => connectWifi(),
              child: const Text("Connect"),
            ),
          ),
          Center(
            child: Text(
              wifiIP!,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              nameWifi,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
 
  }
}
