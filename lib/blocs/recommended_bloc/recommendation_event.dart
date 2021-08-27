part of 'recommendation_bloc.dart';

abstract class RecommendationEvent extends Equatable{
  const RecommendationEvent();
}

class GetRecommendationContent extends RecommendationEvent{

  @override
  List<Object?> get props => [];

}