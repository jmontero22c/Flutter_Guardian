import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:my_app/models/wifi_model.dart';
import 'package:network_info_plus/network_info_plus.dart';


class WifiViewModel extends ChangeNotifier{

  //Connect Wifi SPG
  Future<bool> connectWifi(BuildContext context) async{
    final info = NetworkInfo();
    Wifi wifi = Wifi();
    
    var wifiName = await info.getWifiName();
    
    if (wifiName != null) {    
      wifi.setNameSSID(wifiName);
    }else {
      wifi.setNameSSID('');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("There's no SPG Red", style: TextStyle(fontSize: 15),))
      );      
    }
    
    bool result = false;
    return result;
  }

  //Check if the app have permissions
  Future<bool> isGPSGranted() async{
    Location location = Location();
    final permision = await location.hasPermission();

    if(permision == PermissionStatus.granted){
      return true;
    }
    
    final permisionRequest = await location.requestPermission();
    return permisionRequest == PermissionStatus.granted;
  }
  
  //Check if GPS is active
  Future<bool> isGPSActive() async{
    Location location = Location();

    bool result = false;
    bool _serviceEnabled;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();   
    }
    result = _serviceEnabled;
    return result;
  }

}