part of 'instructor_follow_bloc.dart';

abstract class InstructorFollowEvent extends Equatable {
  const InstructorFollowEvent();
}

class GetInstructorFollowScreen extends InstructorFollowEvent {
  final int instructorID;

  GetInstructorFollowScreen({required this.instructorID});

  @override
  List<Object?> get props => [];
}
