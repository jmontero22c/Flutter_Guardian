import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/components/app_bar.dart';
import 'package:my_app/services/wifi_services.dart';

class Monitoring extends StatefulWidget {
  final String module;
  const Monitoring({super.key, required this.module});

  @override
  State<Monitoring> createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  Timer? _timer;
  bool isExecuting = false;
  WifiServices wifiServices = WifiServices();

  void startTimer(){
    Timer.periodic(const Duration(seconds:  1), (timer) async {
      if (isExecuting) return;
      isExecuting = true;
      wifiServices.sendRequest('[IT]').then((value){
        log(value);
      });
      isExecuting = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(tittle: 'Monitoring $widget.module',),
      body: const Center(
        child: Text('Coming soon...'),
      ),
    );
  }
}