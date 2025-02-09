import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const BotonAzul({
    Key? key,  // Se usa "Key?" en vez de "Key key"
    required this.text, 
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2, // Altura de la sombra
        backgroundColor: Colors.blue, // Color de fondo
        shape: const StadiumBorder(), // Bordes redondeados
      ),
      onPressed: onPressed, // Ya no es necesario "this."
      child: Container(
        width: double.infinity,
        height: 55,
        alignment: Alignment.center,
        child: Text( // Se eliminó "const"
          text,
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
