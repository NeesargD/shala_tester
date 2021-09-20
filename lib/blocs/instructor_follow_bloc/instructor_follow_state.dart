part of 'instructor_follow_bloc.dart';

abstract class InstructorFollowState extends Equatable {
  const InstructorFollowState();
}

class InstructorFollowInitial extends InstructorFollowState {
  @override
  List<Object> get props => [];
}

class InstructorFollowSuccess extends InstructorFollowState {
  final InstructorFollowModel instructorFollowModel;

  InstructorFollowSuccess({required this.instructorFollowModel});

  @override
  List<Object?> get props => [instructorFollowModel];
}

class InstructorFollowFailure extends InstructorFollowState {
  final String message;

  InstructorFollowFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
