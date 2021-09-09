part of 'faq_bloc.dart';

abstract class FaqEvent extends Equatable {
  const FaqEvent();
}

class GetAllFaq extends FaqEvent {
  List<Object?> get props => [];
}
