import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/viewmodels/wifi_viewmodel.dart';
import 'package:provider/provider.dart';

class WifiServices {

  WifiViewModel wifiActions = WifiViewModel();

  Future<String> sendRequest(request) async {
    String result = '';
    var url = Uri.parse("http://192.168.4.1/GuardianAPI?request=$request&timeout=2000");
    var headers = {
      'Content-Type': 'application/json'    
    };
    
    try {
      var response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
    
      if(response.statusCode == 200) {    
        result = jsonDecode(response.body)['dataCPU'].toString();
      } else {
        log("Error");
      }

    } catch (err) {
      if (err is TimeoutException) {
        log("Se agotó el tiempo de espera");
      }
    }

    return result;
  }
  
  Future<String> sendRequestConnect(request) async {
    String result = '';
    var url = Uri.parse(request);
    var headers = {
      'Content-Type': 'application/json'    
    };
    
    try {
      var response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
    
      if(response.statusCode == 200) {    
        result = jsonDecode(response.body)['getSSID'].toString();
      } else {
        log("Error");
      }

    } catch (err) {
      if (err is TimeoutException) {
        log("Se agotó el tiempo de espera");
        
      }
    }

    return result;
  }

  void getAnswerWifiConnect(String answer, BuildContext context){
    RegExp regex = RegExp(r'^\[.*\]$');

    if (regex.hasMatch(answer)){
      // wifiActions.setWifiStatus(true);
      log(wifiActions.wifiStatus.toString());
      Provider.of<WifiViewModel>(context, listen: false).setWifiStatus(true);
      log(wifiActions.wifiStatus.toString());
    }
  }
}