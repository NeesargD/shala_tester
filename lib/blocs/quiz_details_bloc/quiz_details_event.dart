part of 'quiz_details_bloc.dart';

abstract class QuizDetailsEvent extends Equatable {
  const QuizDetailsEvent();
}

class GetQuizDetails extends QuizDetailsEvent {
  @override
  List<Object?> get props => [];
}
