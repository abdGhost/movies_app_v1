import 'package:flutter/material.dart';
import '../services/movie_service.dart';
import 'movie_card_widget.dart';

class MovieListSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const MovieListSection({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: screenHeight * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) => MovieCard(
              movie: movies[index],
              cardHeight: screenHeight * 0.25,
              cardWidth: screenWidth * 0.25,
            ),
          ),
        ),
      ],
    );
  }
}
