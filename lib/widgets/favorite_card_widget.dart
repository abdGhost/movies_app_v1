import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/movie_service.dart';
import '../providers/favorite_provider.dart';
import '../screens/movie_details_screen.dart';

class FavoriteCard extends StatelessWidget {
  final Map<String, dynamic> movie;
  final WidgetRef ref;

  const FavoriteCard({super.key, required this.movie, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(
                movie: Movie(
                  id: movie['id'],
                  title: movie['title'],
                  posterURL: movie['poster'],
                  imdbId: movie['imdbId'],
                ),
              ),
            ),
          );
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.network(
                movie['poster'],
                width: 100,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 60),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Tap to view details",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                ref.read(favoriteProvider.notifier).removeFavorite(movie['id']);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${movie['title']} removed from favorites"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
