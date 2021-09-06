part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  const HomeEvent();
}
class GetAllHomes extends HomeEvent {
  @override
  List<Object?> get props => [];
}