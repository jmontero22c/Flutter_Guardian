import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';
import 'package:my_app/components/app_bar.dart';
import 'package:my_app/components/item_value.dart';
import 'package:my_app/components/nav_drawer.dart';
import 'package:my_app/services/wifi_services.dart';
import 'package:my_app/viewmodels/monitoring_viewmodel.dart';
import 'package:provider/provider.dart';

class Monitoring extends StatefulWidget {
  const Monitoring({super.key});

  @override
  State<Monitoring> createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  bool isExecuting = false;
  WifiServices wifiServices = WifiServices();
  late MonitoringViewModel myModel;

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

  void startTimer(String module, MonitoringViewModel monitoringVM) {
    if(monitoringVM.isTimerActive){
      monitoringVM.setIsTimerActive(!monitoringVM.isTimerActive);
      _timer?.cancel();
      return;
    }
    
    monitoringVM.setIsTimerActive(!monitoringVM.isTimerActive);
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) async {
      if (isExecuting) return;

      isExecuting = true;
      wifiServices.sendRequest(module).then((value) {
        monitoringVM.separateValues(value);
        log(value);
        isExecuting = false;
      }).catchError((e) {
        // _timer.cancel();
      });
    });
    // monitoringVM.separateValues("[D;6000;10000;533;165;FF;0;0;0;0;0;0;0;0;0;0;0;0;533;540;533;186;0;533;186;0;0;0;0;0;0;0;0;563;-56400;565;Godamn;POZOEJEM;4378;4378;BODEGA;;;;50;;100;;;;;;;;;;80625;80625;D]");
  }

  void _scrollToPosition(int index) {
    //   double position = index * 72.0; // Ajusta según la altura de tu ListTile
    //   _controller.animateTo(
    //     position,
    //     duration: Duration(milliseconds: 500),
    //     curve: Curves.easeInOut,
    // );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

    BoxDecoration box_decoration = 
    BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: AppColors.secondColor, 
    );
    
    EdgeInsetsGeometry paddingBoxes = const EdgeInsets.only(bottom: 25, left: 12, right: 12, top: 12);
    EdgeInsetsGeometry marginBoxes = const EdgeInsets.only(bottom: 5, left: 12, right: 12, top: 5);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarCustom(tittle: 'Monitoring $module', iconLeading: IconButton(
            icon: const Icon(Icons.arrow_back),  // Icono de menú para abrir el Drawer
            onPressed: () {
              Navigator.pop(context);
            },
      ),),
      drawer: NavDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        // tooltip: 'Increment',
        onPressed: (){_scaffoldKey.currentState?.openDrawer();},
        child: const Icon(Icons.menu, color: Colors.white, size: 28),
        ),
        
      body: Consumer<MonitoringViewModel>(
        builder: (context, monitoringVM,_){
          return Container(
            margin: const EdgeInsets.only(top: 15),
            
            child:  Column(
              children: [
                //====================Take Messures Button====================//
                  Expanded(
                    child: ListView(
                      shrinkWrap: true, // Esto permite que el ListView se ajuste a su contenido
                      children: [
                        Padding(  
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),   
                    child: Ink(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: AppColors.secondColor,
                        borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                      child: InkWell(
                        onTap: () => startTimer(moduleCommand, monitoringVM),
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
                            Expanded(
                              child: Text(
                                'Take messures',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: monitoringVM.isTimerActive ? Colors.red : AppColors.mainColor,
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
                  // Frequency
                  Container(
                    margin: marginBoxes,
                    padding: paddingBoxes ,
                    decoration: box_decoration,
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('FREQUENCY'),
                        ItemValue(titulo: 'FREC',   value: monitoringVM.validateIsEmpty(1), unitMeasurement: 'Hz', scale: 100),
                        ItemValue(titulo: 'DEVFREC',value: monitoringVM.validateIsEmpty(2), unitMeasurement: '%',  scale: 100)
                      ],
                    ),
                  ),
                  
                  //Voltages
                  Container(
                    margin: marginBoxes,
                    padding: paddingBoxes,
                    decoration: box_decoration,
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('VOLTAGES'),
                        ItemValue(titulo: 'VNOM',value:  monitoringVM.validateIsEmpty(3), unitMeasurement: 'V', scale: 100),
                        ItemValue(titulo: 'VRMS AB' ,value: monitoringVM.validateIsEmpty(4), unitMeasurement: 'V', scale: 100),
                        ItemValue(titulo: 'VRMS BC' ,value: monitoringVM.validateIsEmpty(5), unitMeasurement: 'V', scale: 100),
                        ItemValue(titulo: 'VRMS CA' ,value: monitoringVM.validateIsEmpty(6), unitMeasurement: 'V', scale: 100),
                        ItemValue(titulo: 'VRMS A'  ,value: monitoringVM.validateIsEmpty(7), unitMeasurement: 'V', scale: 100),
                        ItemValue(titulo: 'VRMS B'  ,value: monitoringVM.validateIsEmpty(8), unitMeasurement: 'V', scale: 100),
                        ItemValue(titulo: 'VRMS C'  ,value: monitoringVM.validateIsEmpty(9), unitMeasurement: 'V', scale: 100),
                        ItemValue(titulo: 'VRMS N'  ,value: monitoringVM.validateIsEmpty(10), unitMeasurement: 'V', scale: 100),
                        ItemValue(titulo: 'UNBAL'  ,value: monitoringVM.validateIsEmpty(11), unitMeasurement: '%', scale: 100),
                      ],
                    ),
                  ),
      
                  //Currents
                  Container(
                    margin: marginBoxes,
                    padding: paddingBoxes,
                    decoration: box_decoration,
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('CURRENTS'),
                        ItemValue(titulo: 'AMP A',value:  monitoringVM.validateIsEmpty(15), unitMeasurement: 'A', scale: 100),
                        ItemValue(titulo: 'AMP B' ,value: monitoringVM.validateIsEmpty(16), unitMeasurement: 'A', scale: 100),
                        ItemValue(titulo: 'AMP C' ,value: monitoringVM.validateIsEmpty(17), unitMeasurement: 'A', scale: 100),
                        ItemValue(titulo: 'AMP N' ,value: monitoringVM.validateIsEmpty(18), unitMeasurement: 'A', scale: 100),
                        ItemValue(titulo: 'AMP T' ,value: monitoringVM.validateIsEmpty(19), unitMeasurement: 'A', scale: 100),
                        ItemValue(titulo: 'UNBAL' ,value: monitoringVM.validateIsEmpty(20), unitMeasurement: '%', scale: 100),
                      ],
                    ),
                  ),
      
                  //Apparent Powers
                 Container(
                    margin: marginBoxes,
                    padding: paddingBoxes,
                    decoration: box_decoration,
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('APPARENT POWER'),
                        ItemValue(titulo: 'kVA A',value:  monitoringVM.validateIsEmpty(21), unitMeasurement: 'kVA', scale: 100),
                        ItemValue(titulo: 'kVA B' ,value: monitoringVM.validateIsEmpty(22), unitMeasurement: 'kVA', scale: 100),
                        ItemValue(titulo: 'kVA C' ,value: monitoringVM.validateIsEmpty(23), unitMeasurement: 'kVA', scale: 100),
                        ItemValue(titulo: 'kVA T' ,value: monitoringVM.validateIsEmpty(24), unitMeasurement: 'kVA', scale: 100),
                      ],
                    ),
                  ),
      
                  //Active Powers
                  Container(
                    margin: marginBoxes,
                    padding: paddingBoxes,
                    decoration: box_decoration,
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('ACTIVE POWER'),
                        ItemValue(titulo: 'kW A',value:  monitoringVM.validateIsEmpty(25), unitMeasurement: 'kW', scale: 100),
                        ItemValue(titulo: 'kW B' ,value: monitoringVM.validateIsEmpty(26), unitMeasurement: 'kW', scale: 100),
                        ItemValue(titulo: 'kW C' ,value: monitoringVM.validateIsEmpty(27), unitMeasurement: 'kW', scale: 100),
                        ItemValue(titulo: 'kW T' ,value: monitoringVM.validateIsEmpty(28), unitMeasurement: 'kW', scale: 100),
                      ],
                    ),
                  ),
      
                  //Reactive Power
                  Container(
                    margin: marginBoxes,
                    padding: paddingBoxes,
                    decoration: box_decoration,
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('REACTIVE POWER'),
                        ItemValue(titulo: 'kVAR A',value:  monitoringVM.validateIsEmpty(29), unitMeasurement: 'kVAR', scale: 100, isPowerReactive: monitoringVM.isInductive),
                        ItemValue(titulo: 'kVAR B' ,value: monitoringVM.validateIsEmpty(30), unitMeasurement: 'kVAR', scale: 100, isPowerReactive: monitoringVM.isInductive),
                        ItemValue(titulo: 'kVAR C' ,value: monitoringVM.validateIsEmpty(31), unitMeasurement: 'kVAR', scale: 100, isPowerReactive: monitoringVM.isInductive),
                        ItemValue(titulo: 'kVAR T' ,value: monitoringVM.validateIsEmpty(32), unitMeasurement: 'kVAR', scale: 100, isPowerReactive: monitoringVM.isInductive),
                      ],
                    ),
                  ),
      
                  //Power Factor
                  Container(
                    margin: marginBoxes,
                    padding: paddingBoxes,
                    decoration: box_decoration,
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('POWER FACTOR'),
                        ItemValue(titulo: 'PF',value:  monitoringVM.validateIsEmpty(33), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'DPF' ,value: monitoringVM.validateIsEmpty(34), unitMeasurement: '', scale: 100),
                      ],
                    ),
                  ),
                  
                  //Harmonic Voltages
                  Container(
                    margin: marginBoxes,
                    padding: paddingBoxes,
                    decoration: box_decoration,
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('HARMONIC VOLTAGE'),
                        ItemValue(titulo: 'THDV',value:  monitoringVM.validateIsEmpty(37), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDV3' ,value: monitoringVM.validateIsEmpty(38), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDV5' ,value: monitoringVM.validateIsEmpty(39), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDV7' ,value: monitoringVM.validateIsEmpty(40), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDV11' ,value: monitoringVM.validateIsEmpty(41), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDV13' ,value: monitoringVM.validateIsEmpty(42), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDV17' ,value: monitoringVM.validateIsEmpty(43), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDV19' ,value: monitoringVM.validateIsEmpty(44), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDV23' ,value: monitoringVM.validateIsEmpty(45), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDV25' ,value: monitoringVM.validateIsEmpty(46), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDV29' ,value: monitoringVM.validateIsEmpty(47), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDV31' ,value: monitoringVM.validateIsEmpty(48), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDV35' ,value: monitoringVM.validateIsEmpty(49), unitMeasurement: '', scale: 100),
                      ],
                    ),
                  ), 
      
                  //Harmonic Currents
                  Container(
                    margin: marginBoxes,
                    padding: paddingBoxes,
                    decoration: box_decoration,
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('HARMONIC CURRENTS'),
      
                        ItemValue(titulo: 'THDI',value:  monitoringVM.validateIsEmpty(50), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDI3' ,value: monitoringVM.validateIsEmpty(51), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDI5' ,value: monitoringVM.validateIsEmpty(52), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDI7' ,value: monitoringVM.validateIsEmpty(53), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDI11' ,value: monitoringVM.validateIsEmpty(54), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDI13' ,value: monitoringVM.validateIsEmpty(55), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDI17' ,value: monitoringVM.validateIsEmpty(56), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDI19' ,value: monitoringVM.validateIsEmpty(57), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDI23' ,value: monitoringVM.validateIsEmpty(58), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDI25' ,value: monitoringVM.validateIsEmpty(59), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDI29' ,value: monitoringVM.validateIsEmpty(60), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDI31' ,value: monitoringVM.validateIsEmpty(61), unitMeasurement: '', scale: 100),
                        ItemValue(titulo: 'THDI35' ,value: monitoringVM.validateIsEmpty(62), unitMeasurement: '', scale: 100),
                      ],
                    ),
                  ), 
                  
                
                ],
                  ),
                ),
                
              ],
            ),
          );
        },
        
      ),
    );
  }
}
