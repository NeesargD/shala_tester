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
  @override
  List<Object?> get props => [];
}

class FavouriteFailure extends FavouriteState {
  @override
  List<Object?> get props => [];
}
