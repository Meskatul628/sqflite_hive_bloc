import 'package:bloc_test_demo/features/home/domin/entities/sigin_entities.dart';
import 'package:equatable/equatable.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitail extends SignInState {
  const SignInInitail();
}

class SignInLoading extends SignInState {
  const SignInLoading();
}

class SingInsuscess extends SignInState {
  final SignInResponse signInResponse;

  const SingInsuscess({required this.signInResponse});

  @override
  List<Object?> get props => [signInResponse];
}

class SignInFailure extends SignInState {
  final String message;

  const SignInFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
