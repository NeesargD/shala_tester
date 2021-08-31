part of 'instructor_details_bloc.dart';

abstract class InstructorDetailsState extends Equatable {
  const InstructorDetailsState();
}

class InstructorDetailsInitial extends InstructorDetailsState {
  @override
  List<Object> get props => [];
}

class InstructorDetailsSuccess extends InstructorDetailsState {
  final InstructorDetailsModel instructorDetailsModel;

  InstructorDetailsSuccess({required this.instructorDetailsModel});

  @override
  List<Object?> get props => [instructorDetailsModel];
}

class InstructorDetailsFailure extends InstructorDetailsState {
  final String message;

  InstructorDetailsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
