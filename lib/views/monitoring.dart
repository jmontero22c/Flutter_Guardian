import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';
import 'package:my_app/components/app_bar.dart';
import 'package:my_app/components/box_menu.dart';
import 'package:my_app/services/wifi_services.dart';

class Monitoring extends StatefulWidget {
  const Monitoring({super.key});

  @override
  State<Monitoring> createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  bool isExecuting = false;
  WifiServices wifiServices = WifiServices();
  late Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    try {
      if (_timer != null) {
        _timer?.cancel();
      }
    } catch (e) {/**/}
  }

  void startTimer(String module) {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      if (isExecuting) return;

      isExecuting = true;
      wifiServices.sendRequest(module).then((value) {
        log(value);
        isExecuting = false;
      }).catchError((e) {
        // _timer.cancel();
      });
    });
    log(module);
  }

  @override
  Widget build(BuildContext context) {
    String module = ModalRoute.of(context)!.settings.arguments.toString();
    String moduleCommand = '';
    if (module.contains('M1 ')) {
      moduleCommand = '[IT]';
    } else if (module.contains('M1B')) {
      moduleCommand = '[IV]';
    } else if (module.contains('M2')) {
      moduleCommand = '[OV]';
    } else if (module.contains('M3')) {
      moduleCommand = '[OM]';
    }
    module = module.substring(1,4).trim();
    
    return Scaffold(
      appBar: AppBarCustom(
        tittle: 'Monitoring $module',
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 15),
        
        child:  Column(
          children: [
            //====================Take Messures Button====================//
            Padding(  
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),   
              child: Ink(
                height: 50,
                decoration: const BoxDecoration(
                  color: AppColors.secondColor,
                  borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: InkWell(
                  onTap: () => startTimer(moduleCommand),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  splashColor: Colors.grey,
                  child: Row(                
                    children: [
                      SizedBox(
                        height: 30,
                        width: 70,
                        child: Image.asset(
                          'assets/tomar_medidas.jpg',
                          alignment: Alignment.center,
            
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Take messures',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.fontSecond,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
            
                          ),
                        ),
                      ),
                      const SizedBox(width: 75),
                    ],
                  ),
                ),
              )
            ),
            
            // ====================List of Measurements==================== //
        Expanded(
          child: ListView(
            shrinkWrap: true, // Esto permite que el ListView se ajuste a su contenido
            children: const [
              // Frequency
              BoxMenu(icon: Icons.abc, tittleBox: 'tittleBox', margins: EdgeInsets.all(12)),
              //Voltages
              BoxMenu(icon: Icons.abc, tittleBox: 'tittleBox', margins: EdgeInsets.all(12)),
              //Currents
              BoxMenu(icon: Icons.abc, tittleBox: 'tittleBox', margins: EdgeInsets.all(12)),
              //Apparent Powers
              BoxMenu(icon: Icons.abc, tittleBox: 'tittleBox', margins: EdgeInsets.all(12)),
              //Active Powers
              BoxMenu(icon: Icons.abc, tittleBox: 'tittleBox', margins: EdgeInsets.all(12)),
              //Reactive Power
              BoxMenu(icon: Icons.abc, tittleBox: 'tittleBox', margins: EdgeInsets.all(12)),
              //Power Factor
              BoxMenu(icon: Icons.abc, tittleBox: 'tittleBox', margins: EdgeInsets.all(12)),
              //Harmonic Voltages
              BoxMenu(icon: Icons.abc, tittleBox: 'tittleBox', margins: EdgeInsets.all(12)),
              //Harmonic Currents
              BoxMenu(icon: Icons.abc, tittleBox: 'tittleBox', margins: EdgeInsets.all(12)),
              
            
            ],
          ),
        ),
            
          ],
        ),
      ),
    );
  }
}
