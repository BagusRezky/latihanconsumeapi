import 'package:flutter/material.dart';
import 'package:latihanconsumeapi/httpHelper.dart';
import 'package:latihanconsumeapi/moviedetailpage.dart';

class MovieCategorySelector extends StatefulWidget {
  const MovieCategorySelector({super.key});

  @override
  _MovieCategorySelectorState createState() => _MovieCategorySelectorState();
}

class _MovieCategorySelectorState extends State<MovieCategorySelector> {
  String _selectedCategory = 'popular'; // Default category
  final List<String> _categories = [
    'latest',
    'now_playing',
    'popular',
    'top_rated',
    'upcoming'
  ];
  List<dynamic> _movies = [];
  bool _isLoading = true;
  String _errorMessage = '';
  TextEditingController _searchController =
      TextEditingController(); // Controller for search input
  bool _isSearching = false; // Flag to indicate if a search is being performed

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      List<dynamic>? movies;
      if (_isSearching && _searchController.text.isNotEmpty) {
        movies = await HttpHelper()
            .searchMovies(_searchController.text); // Search for movies
      } else {
        movies = await HttpHelper()
            .getMovies(_selectedCategory); // Get category movies
      }

      if (movies != null) {
        setState(() {
          _movies = movies!;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'No movies found';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load movies: $error';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies: $_selectedCategory'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for movies...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                    _fetchMovies(); // Search movies when search icon is pressed
                  },
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  _isSearching = true;
                });
                _fetchMovies(); // Search movies when the user submits input
              },
            ),
          ),

          // Dropdown for category selection
          DropdownButton<String>(
            value: _selectedCategory,
            items: _categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _isSearching =
                    false; // Reset search mode when changing category
                _selectedCategory = newValue!;
              });
              _fetchMovies(); // Fetch movies when the category changes
            },
          ),

          // Movie List or Loading/Error message
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                    ? Center(child: Text(_errorMessage))
                    : ListView.builder(
                        itemCount: _movies.length,
                        itemBuilder: (context, index) {
                          var movie = _movies[index];
                          return ListTile(
                            leading: Image.network(
                              'https://image.tmdb.org/t/p/w500${movie['poster_path'] ?? ''}',
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                            title: Text(movie['title'] ?? 'No Title'),
                            subtitle: Text(
                                movie['release_date'] ?? 'No Release Date'),
                            onTap: () {
                              // Navigate to movie detail page when tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailPage(movie: movie),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
