import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';

class ItemValue extends StatefulWidget {
  final String titulo;
  final String value;
  final String unitMeasurement;
  final int    scale;
  final bool?  editable;
  final bool? isPowerReactive;
  const ItemValue({
    super.key, 
    required this.titulo,
    required this.value,
    required this.unitMeasurement,
    required this.scale,
    this.editable,
    this.isPowerReactive
  });

  @override
  State<ItemValue> createState() => _ItemValueState();
}

class _ItemValueState extends State<ItemValue> {
  @override
  Widget build(BuildContext context) {
    //Función para colocar los decimales al valor
    String scaleValue(){
      double val1;
      try {
        val1 = double.parse(widget.value) / widget.scale;
      } catch (e) {
        val1 = 0 / widget.scale;
      }
      return val1.toString().replaceAll('.', ',');      
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black))
      ),
      padding: const EdgeInsets.only(bottom: 2, right: 5, left: 5),
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          /***** Titulo del Item *****/
          Expanded(
            child: Text(
              widget.titulo,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 17
              ),
            ),
          ),
          
          /*****Capacitivo o Inductivo ***********/
          if(widget.isPowerReactive == true)
          const SizedBox(
            width: 50,
            height: 25,
            child: Image(
              alignment: Alignment.centerRight,
              image: AssetImage('assets/Capacitor.jpg'),
              color: Colors.red,
            )
          ),

          /***** Valor del Item *****/
          Expanded(
            child: Text(
              scaleValue(),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 17
              ),
            ),
          ),

          const SizedBox(width: 10,),
          /***** Unidad de medida del Item *****/
          Text(
            widget.unitMeasurement,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 17
              ),
          ),

          /***** Boton de editar del Item *****/
          if(widget.editable == true)
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    'assets/lapiz.jpg',
                    alignment: Alignment.center,
                    color: AppColors.mainColor,
                  ),
                ),
                onTap: ()=>log('message'),
              ),
            ),  
        ],
      ),
    );
  }
}