import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favorite_provider.dart';
import '../services/movie_service.dart';

class MovieDetailsContent extends StatelessWidget {
  final Movie movie;
  final bool isFavorite;
  final WidgetRef ref;

  const MovieDetailsContent({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 28,
                ),
                onPressed: () async {
                  if (isFavorite) {
                    ref.read(favoriteProvider.notifier).removeFavorite(movie.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${movie.title} removed from favorites')),
                    );
                  } else {
                    await ref.read(favoriteProvider.notifier).addFavorite({
                      'id': movie.id,
                      'title': movie.title,
                      'poster': movie.posterURL,
                      'imdbId': movie.imdbId,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${movie.title} added to favorites')),
                    );
                  }
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
          AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 500),
            child: const Text(
              "Explore the captivating story of this movie, "
              "its characters, and the incredible journey it takes you on.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white54),
          const SizedBox(height: 10),
          _buildInfoRow(Icons.star, "IMDB ID: ${movie.imdbId}"),
          const SizedBox(height: 10),
          _buildInfoRow(Icons.movie, "Genre: Animation, Adventure"),
          const SizedBox(height: 10),
          _buildInfoRow(Icons.calendar_today, "Release Date: July 19, 2015"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 28),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
