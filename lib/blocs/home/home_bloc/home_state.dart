part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}


class HomeSuccess extends HomeState {
  final HomeModel homeModel;

  HomeSuccess({required this.homeModel});

  @override
  List<Object?> get props => [homeModel];
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
