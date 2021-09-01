part of 'classes_bloc.dart';

abstract class ClassesState extends Equatable {
  const ClassesState();
}

class ClassesInitial extends ClassesState {
  @override
  List<Object> get props => [];
}

class ClassesSuccess extends ClassesState {
  final ClassesModel classesModel;

  ClassesSuccess({required this.classesModel});

  @override
  List<Object?> get props => [classesModel];
}

class ClassesFailure extends ClassesState {
  final String message;

  ClassesFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
