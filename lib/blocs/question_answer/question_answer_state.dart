part of 'question_answer_bloc.dart';

abstract class QuestionAnswerState extends Equatable {
  const QuestionAnswerState();
}

class QuestionAnswerInitial extends QuestionAnswerState {
  @override
  List<Object> get props => [];
}

class QuestionAnswerSuccess extends QuestionAnswerState {
  final String message;

  QuestionAnswerSuccess({required this.message});

  @override
  List<Object?> get props => [];
}

class QuestionAnswerFailure extends QuestionAnswerState {
  final String message;

  QuestionAnswerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
