part of 'classes_details_bloc.dart';

abstract class ClassesDetailsState extends Equatable {
  const ClassesDetailsState();
}

class ClassesDetailsInitial extends ClassesDetailsState {
  @override
  List<Object> get props => [];
}

class ClassDetailsSuccess extends ClassesDetailsState {
  final ClassDetailsModel classDetailsModel;

  ClassDetailsSuccess({required this.classDetailsModel});

  @override
  List<Object?> get props => [classDetailsModel];
}

class ClassDetailsFailure extends ClassesDetailsState {
  final String message;

  ClassDetailsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}