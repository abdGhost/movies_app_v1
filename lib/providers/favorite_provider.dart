import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/database_helper.dart';

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, List<Map<String, dynamic>>>(
  (ref) => FavoriteNotifier(),
);

class FavoriteNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  FavoriteNotifier() : super([]) {
    _loadFavorites();
  }

  final dbHelper = DatabaseHelper.instance;
  Future<void> _loadFavorites() async {
    final favorites = await dbHelper.getFavorites();
    state = favorites;
  }

  Future<void> addFavorite(Map<String, dynamic> movie) async {
    await dbHelper.addFavorite(movie);
    state = [...state, movie];
  }

  Future<void> removeFavorite(int id) async {
    await dbHelper.removeFavorite(id);
    state = state.where((movie) => movie['id'] != id).toList();
  }
}
