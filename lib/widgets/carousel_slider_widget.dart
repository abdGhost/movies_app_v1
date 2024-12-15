import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../services/movie_service.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<Movie> movies;

  const CarouselSliderWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return CarouselSlider(
      options: CarouselOptions(
        height: screenHeight * 0.25,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
      ),
      items: movies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: movie.posterURL,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 100),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
