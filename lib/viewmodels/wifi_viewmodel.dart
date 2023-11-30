import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:network_info_plus/network_info_plus.dart';


class WifiViewModel extends ChangeNotifier{
  // Wifi wifiObject = Wifi(nameSSID: '',ip: '',status: false);

  // wifiObject.nameSSID = "";
  String _wifiName = '';
  bool _wifiStatus = false;
  String _wifiIP = '';
  String _versionCPU = '';

  //Getters
  String get wifiName => _wifiName;
  String get wifiIP => _wifiIP;
  String get versionCPU => _versionCPU;
  bool get wifiStatus => _wifiStatus;

  //Setters
  void setWifiName(String val){
    _wifiName = val;
    notifyListeners();
  }
  void setWifiIP(String val){
    _wifiIP = val;
  }
  void setWifiStatus(bool val){
    _wifiStatus = val;
    notifyListeners();
  }
  void setVersionCPU(String val){
    _versionCPU = val;
    notifyListeners();
  }
  

  //*Connect Wifi SPG
  Future connectWifi(BuildContext context) async{
    final info = NetworkInfo();
    
    var wifiName = await info.getWifiName();
    
    if (wifiName != null) {    
      setWifiName(wifiName);
    }else {
      setWifiName('');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("There's no SPG Red", style: TextStyle(fontSize: 15),))
      );      
    }
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
    bool serviceEnabled;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();   
    }
    result = serviceEnabled;
    return result;
  }

}