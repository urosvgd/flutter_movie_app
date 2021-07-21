part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();
  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesFailed extends MoviesState {}

class MoviesSuccess extends MoviesState {
  final List<Movie> movies;
  final bool hasReachedMax;
  MoviesSuccess({
    this.movies,
    this.hasReachedMax,
  });

  MoviesSuccess copyWith({
    List<Movie> movies,
    bool hasReachedMax,
  }) {
    return MoviesSuccess(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      movies: movies ?? this.movies,
    );
  }

  @override
  List<Object> get props => [movies, hasReachedMax];

  @override
  String toString() =>
      "{ MoviesSuccess: { movies: ${movies.length}, hasReachedMax: $hasReachedMax } }";
}
