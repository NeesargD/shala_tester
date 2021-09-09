part of 'question_answer_bloc.dart';

abstract class QuestionAnswerEvent extends Equatable {
  const QuestionAnswerEvent();
}
class SubmitQuestionAnswer extends QuestionAnswerEvent {
  final List<SubmittedAnswer> submittedAnswers;

  SubmitQuestionAnswer({required this.submittedAnswers});
  List<Object?> get props => [];
}
