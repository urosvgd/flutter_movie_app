import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/cast.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/movie_details.dart';
import 'package:movies_app/models/person.dart';

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

  Future<MovieDetails> fetchMovieDetails({int id}) async {
    final url = '$baseUrl/movie/$id?api_key=$apiKey&language=en-US';
    final response = await httpClient.get(Uri.parse(url));
    if (response.statusCode != 200) {
      // print(response.body);
      // print(id);      
      throw new Exception('There was a problem');
    }
    final decodedJson = jsonDecode(response.body);
    return MovieDetails.fromJson(decodedJson);
  }

  Future<List<Cast>> fetchMovieCast({int id}) async {
    final List<Cast> movieCast = [];
    final url = '$baseUrl/movie/$id/credits?api_key=$apiKey';
    final response = await httpClient.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw new Exception('There was a problem');
    }
    final decodedJson = jsonDecode(response.body);
    (decodedJson['cast'] as List).forEach((element) {
      movieCast.add(Cast.fromJson(element));
    });
    return movieCast;
  }

}
