part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetAllHomes extends HomeEvent {
  List<Object?> get props => [];
}
