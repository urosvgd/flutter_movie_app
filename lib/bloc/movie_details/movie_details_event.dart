part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
  @override
  List<Object> get props => [];
}

class FetchMovieDetails extends MovieDetailsEvent {
  final int id;
  const FetchMovieDetails({this.id});
  @override
  List<Object> get props => [id];
}
