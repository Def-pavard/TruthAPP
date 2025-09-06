import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApiService {
  static const String baseUrl = 'https://votre-backend.herokuapp.com';
  
  static Future<Map<String, dynamic>> verifyText(String content) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/verify'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'content': content}),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erreur lors de la vérification: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
  
  static Future<Map<String, dynamic>> verifyImage(XFile imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);
      final imageData = 'data:image/jpeg;base64,$base64Image';
      
      final response = await http.post(
        Uri.parse('$baseUrl/api/verify-image'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'image': imageData}),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erreur lors de la vérification d\'image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
  
  static Future<Map<String, dynamic>> getDailyFactCheck(String topic) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/daily-fact-check?topic=$topic'),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erreur lors de la récupération des actualités: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
  
  static Future<Map<String, dynamic>> getDailySummary() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/daily-summary'),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erreur lors de la récupération du résumé: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
}