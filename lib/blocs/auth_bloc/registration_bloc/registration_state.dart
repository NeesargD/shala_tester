part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationLoading extends RegistrationState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class RegistrationSuccess extends RegistrationState{
  final String? message;

  RegistrationSuccess({this.message});

  @override
  List<Object?> get props => [];
}

class RegistrationFailure extends RegistrationState{
  final String message;

  RegistrationFailure({required this.message});

  @override
  List<Object?> get props => [];
}