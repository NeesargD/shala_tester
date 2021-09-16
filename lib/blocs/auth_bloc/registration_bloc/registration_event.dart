part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class GetRegistrationDetails extends RegistrationEvent{


  final String name;
  final String email;
  final String password;
  final String? phoneNumber;

  GetRegistrationDetails({required this.name, required this.email, required this.password, this.phoneNumber});

  @override
  List<Object?> get props => [];
}