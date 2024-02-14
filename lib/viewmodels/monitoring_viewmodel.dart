// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/models/guardian_att.dart';

class MonitoringViewModel extends ChangeNotifier{
  GuardianAtt guardian = GuardianAtt();

  //Atributes
  List<String> ? _DATOS_TEXT;
  bool _isTimerActive = false;
  bool _isInductive = false;

  //Separate values by semicolon and storage them into an array called DATOS_TEXT
  void separateValues(String response){
    _isInductive = false;
    _DATOS_TEXT = response.split(';');
    if(_DATOS_TEXT!.isEmpty){
      log('DATOS_TEXT is empty');
      return;
    }

    //Validar Factor de Potencia Negativo
    if(guardian.VERSION_GUARDIAN >= 161 ){
      if(double.parse(_DATOS_TEXT![33]) < 0){
        _DATOS_TEXT![33].substring(1);
        _isInductive = true;
      }
    }
    
    notifyListeners();
  }

  //Before accesing the value in DATOS_TEXT, check before if the position exist.
  String validateIsEmpty(int index){
    var result = '0';
    try {
      result = _DATOS_TEXT![index];
    } catch (e) {
      log('Error trying to acces to DATOS_TEXT');
    }
    return result;
  }

  //getters
  List<String> ? get DATOS_TEXT => _DATOS_TEXT;
  bool get isTimerActive => _isTimerActive;
  bool get isInductive => _isInductive;

  //SETTER
  void setIsTimerActive(bool value){
    _isTimerActive = value;
    notifyListeners();
  }
  void setIsInductive(bool value){
    _isInductive = value;
  }
}