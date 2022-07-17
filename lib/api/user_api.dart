import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final String name;

  const User({
    required this.name,
  });

  static User fromJson(Map<String, dynamic> json) => User(
    name: json['username'],
  );
}

class UserApi {
  static Future<List<User>> getUserSuggestions(String query) async {
    var url = null;
    if(query == ""){
       url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    }else{
       url = Uri.parse('https://jsonplaceholder.typicode.com/users?username='+query);
    }

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
