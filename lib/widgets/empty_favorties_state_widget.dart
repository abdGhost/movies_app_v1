import 'package:flutter/material.dart';

class EmptyFavoritesState extends StatelessWidget {
  const EmptyFavoritesState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.favorite_border, size: 100, color: Colors.white70),
          SizedBox(height: 16),
          Text(
            "No favorites yet.",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
