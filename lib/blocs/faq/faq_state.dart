part of 'faq_bloc.dart';

abstract class FaqState extends Equatable {
  const FaqState();
}

class FaqInitial extends FaqState {
  @override
  List<Object> get props => [];
}

class FaqSuccess extends FaqState {
  final FaqModel faqModel;

  FaqSuccess({required this.faqModel});

  @override
  List<Object?> get props => [faqModel];
}

class FaqFailure extends FaqState {
  final String message;

  FaqFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

