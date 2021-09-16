part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class GetLoginDetails extends LoginEvent{

  final String username;
  final String password;

  GetLoginDetails({required this.username, required this.password});

  @override
  List<Object?> get props => [];
}