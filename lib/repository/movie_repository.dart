import 'package:movies_app/models/cast.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/movie_details.dart';
import 'package:movies_app/service/movie_api_client.dart';

class MovieRepository {
  final ApiClient apiClient;
  MovieRepository({ this.apiClient });

  Future<List<Movie>> fetchMovies({int page}) async {
    return await apiClient.fetchMovies(page: page);
  }
  Future<MovieDetails> fetchMovieDetails({int id}) async {
    return await apiClient.fetchMovieDetails(id: id);
  }

  Future<List<Cast>> fetchMovieCast({int id}) async {
    return await apiClient.fetchMovieCast(id: id);
  }

}