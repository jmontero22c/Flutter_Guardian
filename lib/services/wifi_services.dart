import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class WifiServices {
  
  Future sendRequest() async {
    var url = Uri.parse('http://192.168.4.1/GuardianAPI?request=[SPD_INFOPA00]&timeout=2000');
    var headers = {
      'Content-Type': 'application/json'    
    };
    
    try {
      var response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
    
      if(response.statusCode == 200) {
        log("Conexion Exitosa ${jsonDecode(response.body)}");           
      } else {
        log("Error");
      }

    } catch (err) {
      if (err is TimeoutException) {
        log("Se agotó el tiempo de espera");
        
      }
    }
  }
}