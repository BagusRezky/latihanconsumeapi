import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  final String apiKey = '2338adb348c434c1285c29e7c13f360b';
  final String baseUrl = 'https://api.themoviedb.org/3/movie/';
  final String searchUrl = 'https://api.themoviedb.org/3/search/movie';

  Future<List<dynamic>?> getMovies(String category) async {
    try {
      final String url = '$baseUrl$category?api_key=$apiKey';
      http.Response result = await http.get(Uri.parse(url));

      if (result.statusCode == 200) {
        var data = jsonDecode(result.body);
        return data['results'];
      } else {
        print('Failed to load movies. Status code: ${result.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }

  Future<List<dynamic>?> searchMovies(String query) async {
    try {
      final String url = '$searchUrl?api_key=$apiKey&query=$query';
      http.Response result = await http.get(Uri.parse(url));

      if (result.statusCode == 200) {
        var data = jsonDecode(result.body);
        return data['results'];
      } else {
        print('Failed to search movies. Status code: ${result.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }
}
