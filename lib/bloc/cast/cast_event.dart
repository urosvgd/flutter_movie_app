part of 'cast_bloc.dart';

abstract class CastEvent extends Equatable {
  const CastEvent();
  @override
  List<Object> get props => [];
}

class FetchCast extends CastEvent {
  final int id;
  const FetchCast({this.id});
  @override
  List<Object> get props => [id];
}
