part of 'program_detail_bloc.dart';

abstract class ProgramDetailState extends Equatable {
  const ProgramDetailState();
}

class ProgramDetailInitial extends ProgramDetailState {
  @override
  List<Object> get props => [];
}

class ProgramDetailSuccess extends ProgramDetailState {
  final ProgramDetailModel programDetailModel;

  ProgramDetailSuccess({required this.programDetailModel});

  @override
  List<Object?> get props => [ProgramDetailModel];
}

class ProgramDetailFailure extends ProgramDetailState {
  final String message;

  ProgramDetailFailure({required this.message});

  @override
  List<Object?> get props => [message];
}