import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:movies_app/models/movie.dart';
import 'package:movies_app/repository/movie_repository.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepository movieRepository;
  int page = 1;

  MoviesBloc({this.movieRepository}): super(MoviesInitial());

  MoviesState get initialState => MoviesInitial();

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    final currentState = state;
    if (event is FetchMovies && !_hasReachedMax(currentState)) {
      try {
        if (currentState is MoviesInitial) {
          final movies = await movieRepository.fetchMovies(page: page);
          yield MoviesSuccess(movies: movies, hasReachedMax: false);
          return;
        }

        if (currentState is MoviesSuccess) {
          final movies = await movieRepository.fetchMovies(page: ++page);
          yield movies.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : MoviesSuccess(
                  hasReachedMax: false,
                  movies: currentState.movies + movies,
                );
        }
      } catch (_) {
        yield MoviesFailed();
      }
    }
  }

  bool _hasReachedMax(MoviesState state) =>
      state is MoviesSuccess && state.hasReachedMax;
}