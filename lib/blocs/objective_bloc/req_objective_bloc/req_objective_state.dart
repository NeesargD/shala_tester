part of 'req_objective_bloc.dart';

abstract class ReqObjectiveState extends Equatable {
  const ReqObjectiveState();
}

class ReqObjectiveInitial extends ReqObjectiveState {
  @override
  List<Object> get props => [];
}


class ReqObjectiveSuccess extends ReqObjectiveState {
  final ReqObjectiveModel reqObjectiveModel;

  ReqObjectiveSuccess({required this.reqObjectiveModel});

  @override
  List<Object?> get props => [ReqObjectiveModel];
}

class ReqObjectiveFailure extends ReqObjectiveState {
  final String message;

  ReqObjectiveFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
