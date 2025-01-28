import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';

class GeminiService {
  static const String apiKey = 'AIzaSyBFyrV7YUIdQhJk7iozMz-UU1gzd37FNm0'; // Replace with your API key
  static final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: 'AIzaSyBFyrV7YUIdQhJk7iozMz-UU1gzd37FNm0', // Replace with your API key
  );

  static Future<List<Map<String, dynamic>>> searchPlaces(String query) async {
    try {
      final content = Content.text('''
        You are a travel guide API. Provide information about $query.
        Return a valid JSON array containing exactly 5 relevant places.
        Use this exact format without any additional text or explanations:
        [
          {
            "name": "Place name",
            "description": "Brief description",
            "location": {"lat": 0.0, "lng": 0.0},
            "estimatedBudget": "Budget range in USD",
            "bestTimeToVisit": "Best season or months",
            "highlights": ["highlight1", "highlight2", "highlight3"]
          }
        ]
      ''');

      final response = await model.generateContent(content as Iterable<Content>);
      final responseText = response.text;
      
      try {
        // More robust JSON extraction
        String jsonStr = responseText ?? '';
        if (!jsonStr.startsWith('[')) {
          // Find the first occurrence of [ and last occurrence of ]
          final jsonStart = jsonStr.indexOf('[');
          final jsonEnd = jsonStr.lastIndexOf(']') + 1;
          if (jsonStart >= 0 && jsonEnd > jsonStart) {
            jsonStr = jsonStr.substring(jsonStart, jsonEnd);
          } else {
            print('Invalid JSON format in response');
            return [];
          }
        }
        
        final List<dynamic> parsed = json.decode(jsonStr);
        return List<Map<String, dynamic>>.from(parsed);
      } catch (e) {
        print('Error parsing JSON: $e');
        print('Raw response: $responseText');
        return [];
      }
    } catch (e) {
      print('Error fetching places: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>> getPlaceDetails(String placeName) async {
    try {
      final content = Content.text('''
        You are a travel guide API. Provide detailed information about $placeName.
        Return a valid JSON object using this exact format without any additional text:
        {
          "name": "Full place name",
          "description": "Detailed description",
          "location": {"lat": 0.0, "lng": 0.0},
          "estimatedBudget": "Detailed budget breakdown",
          "bestTimeToVisit": "Best season with weather details",
          "highlights": ["highlight1", "highlight2", "highlight3"],
          "localCuisine": ["dish1", "dish2", "dish3"],
          "culturalNotes": "Cultural information",
          "travelTips": ["tip1", "tip2", "tip3"]
        }
      ''');

      final response = await model.generateContent(content as Iterable<Content>);
      final responseText = response.text;
      
      try {
        // More robust JSON extraction
        String jsonStr = responseText ?? '';
        if (!jsonStr.startsWith('{')) {
          // Find the first occurrence of { and last occurrence of }
          final jsonStart = jsonStr.indexOf('{');
          final jsonEnd = jsonStr.lastIndexOf('}') + 1;
          if (jsonStart >= 0 && jsonEnd > jsonStart) {
            jsonStr = jsonStr.substring(jsonStart, jsonEnd);
          } else {
            print('Invalid JSON format in response');
            return {};
          }
        }
        
        final Map<String, dynamic> parsed = json.decode(jsonStr);
        return parsed;
      } catch (e) {
        print('Error parsing JSON: $e');
        print('Raw response: $responseText');
        return {};
      }
    } catch (e) {
      print('Error fetching place details: $e');
      return {};
    }
  }
} 