import 'package:flutter/material.dart';
import '../services/movie_service.dart';

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeader({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: movie.id,
          child: Image.network(
            movie.posterURL,
            width: double.infinity,
            height: 320,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100),
          ),
        ),
        Container(
          height: 320,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withAlpha((0.8 * 255).toInt()),
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
