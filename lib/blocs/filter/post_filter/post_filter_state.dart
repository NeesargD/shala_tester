part of 'post_filter_bloc.dart';

abstract class PostFilterState extends Equatable {
  const PostFilterState();
}

class PostFilterInitial extends PostFilterState {
  @override
  List<Object> get props => [];
}

// class PostFilterLoading extends PostFilterState{
//   @override
//   List<Object?> get props =>[];
//
// }

class PostFilterSuccess extends PostFilterState{
  final PostFilterModel postFilterModel;

  PostFilterSuccess({required this.postFilterModel});

  @override
  List<Object?> get props => [postFilterModel];
}

class PostFilterFailure extends PostFilterState{
  final String message;

  PostFilterFailure({required this.message});

  @override
  List<Object?> get props => [message];
}