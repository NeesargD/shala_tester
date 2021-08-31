part of 'recommendation_bloc.dart';

abstract class RecommendationState extends Equatable{
  const RecommendationState();
}

class RecommendationInitial extends RecommendationState{
  @override
  List<Object> get props => [];
}

class RecommendationSuccess extends RecommendationState{
  final RecommendationModel recommendationModel;

  RecommendationSuccess({required this.recommendationModel});

  @override
  List<Object?> get props => [recommendationModel];
}

class RecommendationFailure extends RecommendationState {
  final String message;

  RecommendationFailure({required this.message});

  @override
  List<Object?> get props => [message];
}