import 'package:flutter/material.dart';
import 'package:location/location.dart';


class WifiViewModel extends ChangeNotifier{

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