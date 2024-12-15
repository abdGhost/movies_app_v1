import 'package:flutter/material.dart';

class NoMoviesFoundWidget extends StatelessWidget {
  const NoMoviesFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          "No movies found",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
