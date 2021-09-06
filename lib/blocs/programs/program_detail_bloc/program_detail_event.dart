part of 'program_detail_bloc.dart';

abstract class ProgramDetailEvent extends Equatable {
  const ProgramDetailEvent();
}

class GetProgramDetail extends ProgramDetailEvent{
  final int id;

  GetProgramDetail({required this.id});

  @override
  List<Object?> get props => [];
}