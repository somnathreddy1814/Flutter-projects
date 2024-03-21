import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey;
  ApiService(this.apiKey);

  Future<List<Exercise>> fetchExercises(String muscle) async {
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/exercises?muscle=$muscle'),
      headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Exercise>.from(data.map((exerciseData) => Exercise.fromJson(exerciseData)));
    } else {
      throw Exception('Failed to load exercises');
    }
  }
}

class Exercise {
  final String name;
  final String type;
  final String muscle;
  final String equipment;
  final String difficulty;
  final String instructions;

  Exercise({
    required this.name,
    required this.type,
    required this.muscle,
    required this.equipment,
    required this.difficulty,
    required this.instructions,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      type: json['type'],
      muscle: json['muscle'],
      equipment: json['equipment'],
      difficulty: json['difficulty'],
      instructions: json['instructions'],
    );
  }
}
