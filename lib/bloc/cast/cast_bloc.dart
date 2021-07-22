import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/models/cast.dart';
import 'package:movies_app/repository/movie_repository.dart';

part 'cast_event.dart';
part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final MovieRepository movieRepository;

  CastBloc({this.movieRepository}) : super(CastInitial());

  @override
  CastState get initialState => CastInitial();

  @override
  Stream<CastState> mapEventToState(CastEvent event) async* {
    if (event is FetchCast) {
      yield CastLoading();
      try {
        List<Cast> cast = await movieRepository.fetchMovieCast(id: event.id);
        yield CastLoaded(cast: cast);
      } catch (e) {
        yield CastError();
      }
    }
  }
}