import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';

class BoxMenu extends StatelessWidget {
  final IconData icon;
  final String tittleBox;
  final EdgeInsetsGeometry margins;
  const BoxMenu({
    super.key, 
    required this.icon, 
    required this.tittleBox,
    required this.margins
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margins,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondColor, 
      ),
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 50),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            height: 1,
          ),
          Text(
            tittleBox, 
            style: const TextStyle(
              fontSize: 16,
              // fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
              
  }
}