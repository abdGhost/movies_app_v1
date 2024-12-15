import 'dart:convert';
import 'package:http/http.dart' as http;

class Movie {
  final int id;
  final String title;
  final String posterURL;
  final String imdbId;

  Movie({
    required this.id,
    required this.title,
    required this.posterURL,
    required this.imdbId,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterURL: json['posterURL'],
      imdbId: json['imdbId'],
    );
  }
}

class MovieService {
  final String apiUrl = "https://api.sampleapis.com/movies/animation";

  Future<List<Movie>> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load movies. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching movies: $e");
      throw Exception("Failed to fetch movies.");
    }
  }
}
