import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  final dynamic movie; // This will hold the movie details

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title'] ?? 'No Title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display poster image
            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie['poster_path'] ?? ''}',
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 3.0),

            // Movie title
            Text(
              movie['title'] ?? 'No Title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            // Release date
            Text(
              'Release Date: ${movie['release_date'] ?? 'Unknown'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),

            // Movie overview
            Text(
              movie['overview'] ?? 'No Description Available',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
