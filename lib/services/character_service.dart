import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class CharacterService {

  static const baseUrl = 'http://127.0.0.1:3000';

  static Future<String?> saveCharacter({

    required String image,
    required String firstName,
    required String course,

  }) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    print("JWT Token: $token");

    if(token == null) return "No token found. Please Login";

    final response = await http.post(
      Uri.parse('$baseUrl/character/add'),
      headers: { 
        'Content-Type' : 'application/json',
        'Authorization' : 'Bearer $token' 
      },
      body: jsonEncode({
        'image' : image,
        'first_name' : firstName,
        'course' : course
      }),
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if(response.statusCode == 201){

      return "Character Saved Successfully";

    }else{

      return jsonDecode(response.body)['error'] ?? "Error Saving Character";

    }

  }

  static Future<Map<String, dynamic>?> getCharacter() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if(token == null) return null;

    final res = await http.get(

      Uri.parse("$baseUrl/character/me"),
      headers: { 
        'Content-Type' : 'application/json',
        'Authorization' : 'Bearer $token'
      },
      
    );

    if(res.statusCode == 200){
      return jsonDecode(res.body);
    }else{
      print("Failed to get character: ${res.body}");
      return null;
    }

  }

}