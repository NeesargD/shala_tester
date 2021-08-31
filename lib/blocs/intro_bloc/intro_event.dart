part of 'intro_bloc.dart';

abstract class IntroEvent extends Equatable {
  const IntroEvent();
}

class GetIntroScreens extends IntroEvent {
  @override
  List<Object?> get props => [];
}
