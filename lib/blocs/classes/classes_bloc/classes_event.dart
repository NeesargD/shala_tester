part of 'classes_bloc.dart';

abstract class ClassesEvent extends Equatable {
  const ClassesEvent();
}

class GetAllClasses extends ClassesEvent {
  @override
  List<Object?> get props => [];
}
