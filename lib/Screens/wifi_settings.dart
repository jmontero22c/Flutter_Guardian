import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';

class WifiSettings extends StatelessWidget {
  const WifiSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          textStyle: const TextStyle(
            color: Color(0xFFFFFFFF),
          ),
          backgroundColor: Colors.white,
        );
    return Scaffold(  
      appBar: AppBar(
        // backgroundColor: secondColor,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Wiffi Setting", style: TextStyle(color: mainColor),),
        iconTheme: const IconThemeData(color: mainColor),
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