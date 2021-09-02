part of 'instructor_bloc.dart';

abstract class InstructorState extends Equatable {
  const InstructorState();
}

class InstructorInitial extends InstructorState {
  @override
  List<Object> get props => [];
}

class InstructorSuccess extends InstructorState {
  final InstructorModel instructorModel;

  InstructorSuccess({required this.instructorModel});

  @override
  List<Object?> get props => [instructorModel];
}

class InstructorFailure extends InstructorState {
  final String message;

  InstructorFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
