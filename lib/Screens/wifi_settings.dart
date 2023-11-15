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
  var locationStatus = Permission.location.status;
  List wifiObject = [];

  @override
  void initState(){
    super.initState();
    getPermission();
  }

  Future<void> getPermission() async{
    var locationStatus = await Permission.location.status;
    if (locationStatus.isDenied){
      await Permission.locationWhenInUse.request();
    }
    if (await Permission.location.isRestricted) {
      openAppSettings();
    }
  }

  Future<void> searchWIFI() async {
    var wifiName = await info.getWifiName();
    wifiObject.clear();

    if (wifiName != null) {
      setState(() {
        wifiObject.add([wifiName, false]);
      });
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("There's no SPG Red", style: TextStyle(fontSize: 15),))
      ); 
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        title: const Text("Wiffi Setting", style: TextStyle(color: AppColors.mainColor),),
        iconTheme: const IconThemeData(color: AppColors.mainColor),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 6),
            decoration:  const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFFe1edf0)),
                right: BorderSide(width: 1.0, color: Color(0xFFe1edf0)),
                left: BorderSide(width: 1.0, color: Color(0xFFe1edf0)),
                top: BorderSide(width: 1.0, color: Color(0xFFe1edf0)),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20), 
                bottomRight: Radius.circular(20)
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  // margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    "Connect WIFI",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22
                      
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    onPressed: () => searchWIFI(),
                    child: const Icon(Icons.refresh),
                    
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: wifiObject.length,
              itemBuilder: (context, index) {
                return WifiItem( nameWifi: wifiObject[0][0], statusWifi: true );
              },
            ),
          )
          
          
        ],
      ),
    );
 
  }
}


//Lista Wifi
class WifiItem extends StatelessWidget {
  final String nameWifi;
  final bool statusWifi;
  const WifiItem({super.key, required this.nameWifi, required this.statusWifi});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Color(0xFFe1edf0)),
          ),
          
        ),
        
        child: Row(
          children: [
            Icon(
              Icons.wifi,
              color: statusWifi ? Colors.green : Colors.red,
              size: 40,
            ),
            Text(
              nameWifi,
              style: TextStyle(
                color: statusWifi ? Colors.white : Colors.red,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
              
            )
          ],
        ),
      ),
    );
  }
}
