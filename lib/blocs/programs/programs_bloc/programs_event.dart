part of 'programs_bloc.dart';

abstract class ProgramsEvent extends Equatable {
  const ProgramsEvent();
}

class GetAllPrograms extends ProgramsEvent {
  @override
  List<Object?> get props => [];
}
