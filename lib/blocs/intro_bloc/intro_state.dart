part of 'intro_bloc.dart';

abstract class IntroState extends Equatable {
  const IntroState();
}

class IntroInitial extends IntroState {
  @override
  List<Object> get props => [];
}

class IntroSuccess extends IntroState {
  final OnboardingModel onboardingModel;

  IntroSuccess({required this.onboardingModel});

  @override
  List<Object?> get props => [onboardingModel];
}

class IntroFailure extends IntroState {
  final String message;

  IntroFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
