import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';
import 'package:my_app/components/app_bar.dart';
import 'package:my_app/services/wifi_services.dart';
import 'package:my_app/viewmodels/wifi_viewmodel.dart';
import 'package:provider/provider.dart';

class WifiSettings extends StatefulWidget {
  const WifiSettings({super.key});

  @override
  State<WifiSettings> createState() => _WifiSettings();
}

class _WifiSettings extends State<WifiSettings> {
  //Usar los metodos especificos para el wifi
  WifiViewModel wifiActions = WifiViewModel();
  bool isItemPressed = false;

  List wifiObject = [];

  @override
  void initState(){
    getPermission();
    super.initState();
  }

  void getPermission(){  
    wifiActions.isGPSGranted().then((isGranted) => {
      //Valida si tiene permiso para usar la localización
      if(isGranted){
        wifiActions.isGPSActive().then((isTurnedOn) => {  
          //Valida si tiene el GPS activado 
          if(!isTurnedOn){
            if (mounted) Navigator.pop(context)  
          }
        // ignore: body_might_complete_normally_catch_error
        }).catchError((err){

        })
      }else{
        if (mounted) Navigator.pop(context)
      }
    });
  }

  void searchWIFI(BuildContext context) {   
    wifiObject.clear();
    wifiActions.connectWifi(context).then((i) {
      setState(() {
        if(wifiActions.wifiName.isNotEmpty){
          wifiObject.add([wifiActions.wifiName, wifiActions.wifiStatus]);
        } 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(tittle: 'Wi-Fi Settings'),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /**************Lista de Wifi**************/
          Consumer<WifiViewModel>(
            builder: (context, wifiViewModel, _) {
              return Expanded(
                child: ListView.builder(
                itemCount: wifiObject.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    child: WifiItem(
                      nameWifi: wifiActions.wifiName,
                      statusWifi: wifiViewModel.wifiStatus,
                    ),
                  );
                },
              ),
            );
            },
          ),
          /**************Boton de Buscar**************/
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
            child: Ink(
              height: 55,
              decoration: const BoxDecoration(
                color: AppColors.secondColor,
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: InkWell(
                onTap: () => searchWIFI(context),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                splashColor: Colors.grey,
                child:const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Search Wifi',
                    style: TextStyle(
                      color: AppColors.fontSecond,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]
      )
    );
  }
}


//Lista Wifi
class WifiItem extends StatelessWidget {
  final String nameWifi;
  final bool statusWifi;
  WifiItem({super.key, required this.nameWifi, required this.statusWifi});

  final WifiServices peticion = WifiServices();

  void getInfoData(WifiViewModel wifiViewModel) async{
    List<String> responseData;
    await peticion.sendRequest('[INFOVERSION]').then((value){
      
      responseData = value.split(';');
      wifiViewModel.setVersionCPU(int.parse(responseData[1]));
      wifiViewModel.setModules(responseData[2]);
    });
  }

  void connectWifi(WifiViewModel wifiViewModel){
    
    peticion.sendRequestConnect('http://192.168.4.1/GetSSID?request=ssid').then((value) {
      try{
        RegExp regex = RegExp(r'^\[.*\]$');
        //Si ya está conectado, desconecta
        if (wifiViewModel.wifiStatus){
          wifiViewModel.setWifiStatus(false);
          wifiViewModel.setWifiName('NONE');
          return; 
        }
        //Si el wifi responde, conecta, de lo contrario desconecta.
        if (regex.hasMatch(value)){
          getInfoData(wifiViewModel);
          wifiViewModel.setWifiStatus(true); 
          wifiViewModel.setWifiName(nameWifi);    
           
        }else{
          wifiViewModel.setWifiStatus(false);
          wifiViewModel.setWifiName('NONE');
        }
      }catch (e) {
        log(e.toString());
      }    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.secondColor,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Consumer<WifiViewModel>(
        builder: (context,wifiViewModel,_){
          return InkWell(
          onTap: (){
            connectWifi(wifiViewModel);
          },
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          splashColor: Colors.grey,
          child:Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                const SizedBox(width: 15),
                /***********ICONO WIFI***********/
                Icon(
                  Icons.wifi,
                  color: statusWifi ? Colors.green : Colors.red,
                  size: 40,
                ),
                const SizedBox(width: 5),
                /***********TEXTO WIFI***********/
                Text(
                  nameWifi,
                  style: const TextStyle(
                    color: AppColors.fontSecond,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
                /***********FLECHA WIFI***********/
                const Expanded( 
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        );
        },
      ),
    );
  }
}
