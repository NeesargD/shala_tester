part of 'res_objective_bloc.dart';

abstract class ResObjectiveEvent extends Equatable {
  const ResObjectiveEvent();
}

class ResObjective extends ResObjectiveEvent {
  final int objectiveId;

  ResObjective({required this.objectiveId});

  @override
  List<Object?> get props => [];
}
