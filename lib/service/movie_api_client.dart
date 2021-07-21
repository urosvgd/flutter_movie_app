import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/movie.dart';

import '../constants.dart';

class ApiClient {
  final baseUrl = "https://api.themoviedb.org/3";
  final http.Client httpClient;

  ApiClient({this.httpClient});
  Future<List<Movie>> fetchMovies({ int page}) async {
    final List<Movie> movies = [];
    final url =
        "$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=$page";
    final response = await httpClient.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw new Exception(
          "The response status code is not 200, check connection");
    }

    final json = jsonDecode(response.body);

    (json['results'] as List).forEach((element) {
      movies.add(Movie.fromJson(element));
    });

    return movies;
  }
}
