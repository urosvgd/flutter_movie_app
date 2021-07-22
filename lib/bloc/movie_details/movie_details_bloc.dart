import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/models/movie_details.dart';
import 'package:movies_app/repository/movie_repository.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieRepository movieRepository;

  MovieDetailsBloc({this.movieRepository}) : super(MovieDetailsInitial());

  MovieDetailsState get initialState => MovieDetailsInitial();

  @override
  Stream<MovieDetailsState> mapEventToState(MovieDetailsEvent event) async* {
    if (event is FetchMovieDetails) {
      yield MovieDetailsLoading();
      try {
        MovieDetails movieDetails =
            await movieRepository.fetchMovieDetails(id: event.id);
        yield MovieDetailsLoaded(movieDetails: movieDetails);
        return;
      } catch (e) {
        yield MovieDetailsError();
      }
    }
  }
}