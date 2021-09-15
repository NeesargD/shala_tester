part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();
}

class FavouriteInitial extends FavouriteState {
  @override
  List<Object> get props => [];
}

class FavouriteLoading extends FavouriteState {
  @override
  List<Object?> get props => [];
}

class FavouriteSuccess extends FavouriteState {
  final String message;

  FavouriteSuccess({required this.message});
  @override
  List<Object?> get props => [];
}

class FavouriteFailure extends FavouriteState {
  final String message;

  FavouriteFailure({required this.message});
  @override
  List<Object?> get props => [];
}
