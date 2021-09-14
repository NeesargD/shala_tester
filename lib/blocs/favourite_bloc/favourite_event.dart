part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();
}

class AddToFavourite extends FavouriteEvent {
  final int? classId;
  final int? programId;
  final String contentType;

  AddToFavourite({this.classId, this.programId, required this.contentType});

  @override
  List<Object?> get props => [];
}
