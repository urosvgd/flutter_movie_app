import 'package:movies_app/models/movie.dart';
import 'package:movies_app/service/movie_api_client.dart';

class MovieRepository {
  final ApiClient apiClient;
  MovieRepository({ this.apiClient });

  Future<List<Movie>> fetchMovies({int page}) async {
    return await apiClient.fetchMovies(page: page);
  }
}