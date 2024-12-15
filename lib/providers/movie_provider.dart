import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/movie_service.dart';

final movieServiceProvider = Provider((ref) => MovieService());

final movieListProvider = FutureProvider<List<Movie>>((ref) async {
  final movieService = MovieService();
  return movieService.fetchMovies();
});
