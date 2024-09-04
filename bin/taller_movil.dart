
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final int id;
  final String name;
  final String username;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}

Future<List<User>> fetchUsers() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');  
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Error al obtener los usuarios');
  }
}


void filtrarUsuariosPorNombre(List<User> users) {
  List<User> filteredUsers = users.where((user) => user.username.length > 6).toList();
  
  print('Usuarios con nombre de más de 6 caracteres:');
  for (var user in filteredUsers) {
    print('${user.name} (${user.username})');
  }
}

void cantidadDeUsuariosConBiz(List<User> users) {
  int count = users.where((user) => user.email.endsWith('@biz')).length;
  
  print('Cantidad de usuarios con email en el dominio biz: $count');
}


void main() async{
  try {
    List<User> users = await fetchUsers();
    print(users.length);
    
    filtrarUsuariosPorNombre(users);

    cantidadDeUsuariosConBiz(users);
  } catch (e) {
    print('Ocurrió un error: $e');
  }
}
