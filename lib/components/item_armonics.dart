import 'package:flutter/material.dart';

class ItemArcomics extends StatefulWidget {
  final String titulo;
  final String value;
  final int    scale;
  const ItemArcomics({
    super.key, 
    required this.titulo,
    required this.value,
    required this.scale,
  });

  @override
  State<ItemArcomics> createState() => _ItemArcomicsState();
}

class _ItemArcomicsState extends State<ItemArcomics> {
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
      return val1.toStringAsFixed(2).replaceAll('.', ',');      
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

          /***** Valor del Item A *****/
          Expanded(
            child: Text(
              scaleValue(),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 17
              ),
            ),
          ),

          /***** Valor del Item B *****/
          Expanded(
            child: Text(
              scaleValue(),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 17
              ),
            ),
          ),

          /***** Valor del Item C *****/
          Expanded(
            child: Text(
              scaleValue(),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 17
              ),
            ),
          ),
        ],
      ),
    );
  }
}