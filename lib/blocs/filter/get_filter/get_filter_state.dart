part of 'get_filter_bloc.dart';

abstract class GetFilterState extends Equatable {
  const GetFilterState();
}

class GetFilterInitial extends GetFilterState {
  @override
  List<Object> get props => [];
}

class GetFilterSuccess extends GetFilterState {
  final GetFilterModel getFilterModel;

  GetFilterSuccess({required this.getFilterModel});

  @override
  List<Object?> get props => [GetFilterModel];
}

class GetFilterFailure extends GetFilterState {
  final String message;

  GetFilterFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
