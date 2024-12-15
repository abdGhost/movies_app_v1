import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favorite_provider.dart';
import '../widgets/empty_favorties_state_widget.dart';
import '../widgets/favorite_card_widget.dart';
import '../widgets/app_bar_widget.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: const AppBarWidget(
        title: "Favorites",
        showBackIcon: true,
      ),
      backgroundColor: Colors.black,
      body: favorites.isEmpty
          ? const EmptyFavoritesState()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final movie = favorites[index];
                return FavoriteCard(movie: movie, ref: ref);
              },
            ),
    );
  }
}
