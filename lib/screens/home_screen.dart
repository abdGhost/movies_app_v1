import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/movie_list_widget.dart';
import '../widgets/no_movies_found_widget.dart';
import '../widgets/carousel_slider_widget.dart';
import '../providers/movie_provider.dart';
import '../widgets/serach_widget.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(movieListProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(
          title: "What would you like to watch?",
          showBackIcon: false,
        ),
      ),
      body: moviesAsync.when(
        data: (movies) {
          final filteredMovies = movies.where((movie) => movie.title.toLowerCase().contains(searchQuery.toLowerCase())).toList();

          final isSearchActive = searchQuery.isNotEmpty;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBarWidget(ref: ref),
                  if (filteredMovies.isEmpty)
                    const NoMoviesFoundWidget()
                  else ...[
                    CarouselSliderWidget(movies: movies),
                    const SizedBox(height: 40),
                    MovieListSection(
                      title: "Popular Movies",
                      movies: filteredMovies,
                    ),
                    const SizedBox(height: 30),
                    if (!isSearchActive)
                      MovieListSection(
                        title: "Upcoming Movies",
                        movies: movies.reversed.toList(),
                      ),
                  ],
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(
          child: Text(
            "Oops! Something went wrong. Please try again later.",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
