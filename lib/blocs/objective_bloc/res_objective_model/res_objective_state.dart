part of 'res_objective_bloc.dart';

abstract class ResObjectiveState extends Equatable {
  const ResObjectiveState();
}

class ResObjectiveInitial extends ResObjectiveState {
  @override
  List<Object> get props => [];
}

class ResObjectiveSuccess extends ResObjectiveState{
  final ResObjectiveModel resObjectiveModel;

  ResObjectiveSuccess({required this.resObjectiveModel});

  @override
  List<Object?> get props => [resObjectiveModel];
}

class ResObjectiveFailure extends ResObjectiveState{
  final String message;

  ResObjectiveFailure({required this.message});

  @override
  List<Object?> get props => [message];
}