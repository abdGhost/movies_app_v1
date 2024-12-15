import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favorite_provider.dart';
import '../services/movie_service.dart';
import '../widgets/movie_details_content_widget.dart';
import '../widgets/movie_details_header_widget.dart';
import '../widgets/app_bar_widget.dart';

class MovieDetailsScreen extends ConsumerWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteProvider);

    final isFavorite = favorites.any((fav) => fav['id'] == movie.id);

    return Scaffold(
      appBar: AppBarWidget(
        title: movie.title,
        showBackIcon: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieDetailsHeader(movie: movie),
            MovieDetailsContent(movie: movie, isFavorite: isFavorite, ref: ref),
          ],
        ),
      ),
    );
  }
}
