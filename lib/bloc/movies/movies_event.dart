part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMovies extends MoviesEvent {}

class FetchMovie extends MoviesEvent {
  final String movieName;
  FetchMovie({this.movieName});
}