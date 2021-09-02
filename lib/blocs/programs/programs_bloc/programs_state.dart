part of 'programs_bloc.dart';

abstract class ProgramsState extends Equatable {
  const ProgramsState();
}

class ProgramsInitial extends ProgramsState {
  @override
  List<Object> get props => [];
}

class ProgramsSuccess extends ProgramsState {
  final ProgramsModel programsModel;

  ProgramsSuccess({required this.programsModel});

  @override
  List<Object?> get props => [programsModel];
}

class ProgramsFailure extends ProgramsState {
  final String message;

  ProgramsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}