part of 'instructor_details_bloc.dart';

abstract class InstructorDetailsEvent extends Equatable {
  const InstructorDetailsEvent();
}

class GetInstructorDetailsScreen extends InstructorDetailsEvent {
  final int id;

  GetInstructorDetailsScreen({required this.id});

  @override
  List<Object?> get props => [];
}