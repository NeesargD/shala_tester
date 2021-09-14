part of 'get_filter_bloc.dart';

abstract class GetFilterEvent extends Equatable {
  const GetFilterEvent();
}

class GetAllFilter extends GetFilterEvent {
  List<Object?> get props => [];
}
