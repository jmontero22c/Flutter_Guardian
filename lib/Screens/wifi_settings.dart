import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';
import 'package:http/http.dart' as http;

class WifiSettings extends StatelessWidget {
  const WifiSettings({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(  
      appBar: AppBar(
        title: const Text("Wiffi Setting", style: TextStyle(color: AppColors.mainColor),),
        iconTheme: const IconThemeData(color: AppColors.mainColor),
      ),
      body: const Center(
        child: ElevatedButton(
          // style: style,
          onPressed: null,
          child: Text('Disabled'),
        ),
      ),
    );
 
  }
}