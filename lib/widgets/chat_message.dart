 import 'package:flutter/material.dart';

 class ChatMessage extends StatelessWidget {

  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    super.key, 
    required this.texto, 
    required this.uid, 
    required this.animationController 
    
    }); 


   
   @override
   Widget build(BuildContext context) {
     return FadeTransition(
      opacity: animationController,
       child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
         child: Container(
          child: this.uid == '123'
          ? _myMessage()
          : _notMyMessage(),
         ),
       ),
     );
   }
Widget _myMessage() {
  return Align(
    alignment: Alignment.centerRight, // Debería estar a la derecha
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(
        right: 5, // Ajustar margen derecho
        bottom: 5,
        left: 50, // Para evitar que ocupe toda la pantalla
      ),
      child: Text(this.texto, style: TextStyle(color: Colors.white)),
      decoration: BoxDecoration(
        color: Color(0xff4D9EF6), // Azul para el mensaje propio
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

Widget _notMyMessage() {
  return Align(
    alignment: Alignment.centerLeft, // Debería estar a la izquierda
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(
        left: 5, // Ajustar margen izquierdo
        bottom: 5,
        right: 50, // Para evitar que ocupe toda la pantalla
      ),
      child: Text(this.texto, style: TextStyle(color: Colors.black87)),
      decoration: BoxDecoration(
        color: Color(0xffE4E5E8), // Gris para los mensajes de otros
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}



 }