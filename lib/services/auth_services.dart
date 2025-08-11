import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/TodoModels.dart';


class AuthService {

  // adb reverse tcp:3000 tcp:3000 (To Run The Server in the Mobile App)
  static const baseUrl = 'http://127.0.0.1:3000';

  static Future<String?> login(String username, String password) async {

    final res = await http.post(

      Uri.parse('$baseUrl/user/login'),
      headers: { 'Content-Type' : 'application/json' },
      body: jsonEncode({ 'username' : username, 'password' : password }),

    );

    final data = jsonDecode(res.body);

    print("Status Code: ${res.statusCode}");
    print("Response Body: ${res.body}");

    if(res.statusCode == 200) {

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', data['token']);
      return "Login Successful";

    }else{
      return data['error'] ?? 'Login error';
    }

  }

   static Future<String> register(String username, String password) async {

    final res = await http.post(

      Uri.parse('$baseUrl/user/register'),
      headers: { 'Content-Type' : 'application/json' },
      body: jsonEncode({ 'username' : username, 'password' : password }),

    );

    final data = jsonDecode(res.body);

    if(res.statusCode == 200) {

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', data['token']);
      return "Registration Successful";
    
    } else {

      return data['error'] ?? 'Registration error';

    }

  }

  static Future<String> createTodo({

    required String title,
    required String description,
    required String month,
    required String day,

  }) async {

    final token = await getToken();

    final res = await http.post(

      Uri.parse('$baseUrl/todo/create'),
      headers: {
        'Content-Type'  : 'application/json',
        'Authorization' : 'Bearer $token'
      },
      body: jsonEncode({

        'title': title,
        'description': description,
        'month': month,
        'day': day,

      }),

    );

    final data = jsonDecode(res.body);
    
    if (res.statusCode == 200) {
      return "To-Do Created";
    } else {
      return data['error'] ?? 'Creation error';
    }

  }

  static Future<List<ToDoModel>> fetchTodos() async {

    final token = await getToken();

    final res = await http.get(

      Uri.parse('$baseUrl/todo/all'),
      headers: {
        'Content-Type'  : 'application/json',
        'Authorization' : 'Bearer $token'
      },
      
    );

    if (res.statusCode == 200) {

      final List<dynamic> data = jsonDecode(res.body);
      return data.map((json) => ToDoModel.fromJson(json)).toList();

    } else {

      throw Exception('Failed to load to-dos');

    }

  }

  static Future<String> deleteTodo(int id) async {

    final token = await getToken();

    final res = await http.delete(

      Uri.parse('$baseUrl/todo/delete/$id'),
      headers: {
        'Content-Type'  : 'application/json',
        'Authorization' : 'Bearer $token'
      },

    );

    if(res.statusCode == 200) return "To-do Deleted";
    else {

      final data = jsonDecode(res.body);
      return data['error'] ?? 'Delete Failed';

    }

  }

  static Future<String?> getToken() async {

    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');

  }

}


// Different use of tokens

// Save Token After login
// Future<void> saveToken(String token) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('jwt_token', token);
// }

// In Authenticated Request
// Future<String?> getToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString('jwt_token');
// }

// For API Request
// Future<void> getUserData() async {
//   final token = await getToken();
//   final response = await http.get(
//     Uri.parse('http://your-ip:3000/user/protected-endpoint'),
//     headers: {
//       'Authorization': 'Bearer $token',
//     },
//   );

//   if (response.statusCode == 200) {
//     // Successfully retrieved data
//   } else {
//     // Token expired or invalid
//   }
// }

// Clear When Log out
// Future<void> logout() async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.remove('jwt_token');
// }