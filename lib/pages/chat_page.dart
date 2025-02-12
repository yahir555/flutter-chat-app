import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

final _textController = new TextEditingController();
final _focusNode = new FocusNode();

List<ChatMessage> _messsage =[];

bool _estaEscribiendo = false;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text('Te', style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3),
            Text('Melissa Flores', style: TextStyle(color: Colors.black87, fontSize: 12)),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _messsage.length,
              itemBuilder: (_, i) => _messsage[i],
              reverse: true,
            ),
          ),

          // Corrección: Envolver el Divider dentro de un Container
          Container(
            child: Divider(height: 1),
          ),

          Container(
            color: Colors.white,
            child: _inputChat(),
          ),
        ],
      ),
    );
  }

  Widget _inputChat(){

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric( horizontal: 8.0),
        child: Row(
          children: <Widget>[

            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                  onChanged: ( String texto){
                  setState(() {
                    if ( texto.trim().length > 0){
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric( horizontal: 4.0),
              child: Platform.isIOS
              ? CupertinoButton(
                child: Text('Enviar'), 
                onPressed: _estaEscribiendo
                  ? () => _handleSubmit( _textController.text.trim() )
                  : null, 
              )
              : Container(
                margin: EdgeInsets.symmetric( horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[400]),

                  child: IconButton(
                    
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.send),
                    onPressed: _estaEscribiendo
                    ? () => _handleSubmit( _textController.text.trim() )
                    : null, 
                    ),
                ),
              ),
            )
          ],
        ),
      ),   
    );
  }

  _handleSubmit( String texto){

    if( texto.length == 0 ) return; 

    print( texto );  
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: '123', 
      texto: texto,
      animationController: AnimationController(vsync: this, duration: Duration( milliseconds: 400)),
      );
    _messsage.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false; 
    });
  }

@override
  void dispose() {
    // TODO: Off del socket
    for( ChatMessage message in _messsage ){
      message.animationController.dispose();
    }

    super.dispose();
  }

}
