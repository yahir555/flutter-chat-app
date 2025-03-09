import 'package:chat/models/mensajes_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat/global/environment.dart';
import 'package:chat/models/usuario.dart';

class ChatService with ChangeNotifier {

  late Usuario usuarioPara;

  // Método para obtener el chat con un usuario específico
  Future<List<Mensaje>> getChat(String usuarioID) async {
    try {
      // Aseguramos que el token no sea nulo antes de hacer la solicitud
      final token = await AuthService.getToken();
      if (token == null) {
        throw Exception('No se encontró el token de autenticación');
      }

      final url = Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID');

      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });

      // Verificamos el código de estado de la respuesta
      if (resp.statusCode == 200) {
        final mensajesResp = mensajesResponseFromJson(resp.body);
        return mensajesResp.mensajes;
      } else {
        // Si el estado no es 200, lanzamos una excepción
        throw Exception('Error al obtener los mensajes: ${resp.statusCode}');
      }
    } catch (e) {
      // Si ocurre un error, lo mostramos en la consola
      print('Error en la solicitud: $e');
      return [];
    }
  }
}
