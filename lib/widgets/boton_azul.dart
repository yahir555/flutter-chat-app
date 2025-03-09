import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BotonAzul({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shape: StadiumBorder(),
        backgroundColor: Colors.blue, // Color del fondo
        foregroundColor: Colors.white, // Color del texto (reemplazando 'onPrimary')
        minimumSize: Size(double.infinity, 55), // Tamaño del botón
      ),
      onPressed: () => onPressed(),
      child: Text(
        text,
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
