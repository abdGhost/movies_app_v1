import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/movie_service.dart';
import '../screens/movie_details_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double cardHeight;
  final double cardWidth;

  const MovieCard({
    super.key,
    required this.movie,
    required this.cardHeight,
    required this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: cardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: movie.posterURL,
              placeholder: (context, url) => const Icon(Icons.image, size: 100, color: Colors.grey),
              errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 100),
              height: cardHeight * 0.75,
              width: cardWidth,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5),
            Text(
              movie.title,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
