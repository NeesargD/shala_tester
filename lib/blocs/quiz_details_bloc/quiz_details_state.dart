part of 'quiz_details_bloc.dart';

abstract class QuizDetailsState extends Equatable {
  const QuizDetailsState();
}

class QuizDetailsInitial extends QuizDetailsState {
  @override
  List<Object> get props => [];
}

class QuizDetailsSuccess extends QuizDetailsState {
  final QuizModel quizModel;

  QuizDetailsSuccess({required this.quizModel});

  @override
  List<Object?> get props => [quizModel];
}

class QuizDetailsFailure extends QuizDetailsState {
  final String message;

  QuizDetailsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}