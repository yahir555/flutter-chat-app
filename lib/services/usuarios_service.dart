import 'package:http/http.dart' as http;
import 'package:chat/models/usuario.dart';
import 'package:chat/models/usuarios_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/global/environment.dart';

class UsuariosService {

  Future<List<Usuario>> getUsuarios() async {
    try {
      // Usamos Uri.parse para evitar errores de formato en la URL
      final url = Uri.parse('${Environment.apiUrl}/usuarios');

      final token = await AuthService.getToken();

      // Aseguramos que el token no sea nulo
      if (token == null) {
        throw Exception('Token no encontrado');
      }

      final resp = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        },
      );

      // Verificamos que la respuesta haya sido exitosa (código 200)
      if (resp.statusCode == 200) {
        final usuariosResponse = usuariosResponseFromJson(resp.body);
        return usuariosResponse.usuarios;
      } else {
        throw Exception('Error al obtener los usuarios: ${resp.statusCode}');
      }
    } catch (e) {
      // Registramos el error en consola para depuración
      print('Error: $e');
      return [];
    }
  }
}
