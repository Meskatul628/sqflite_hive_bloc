import 'package:equatable/equatable.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends SignInEvent {
  final String? email;
  final String? password;

  const LoginEvent({this.email, this.password});

  @override
  List<Object?> get props => [email, password];
}
