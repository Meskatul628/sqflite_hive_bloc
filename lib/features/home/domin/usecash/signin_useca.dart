import 'package:bloc_test_demo/core/error/failure.dart';
import 'package:bloc_test_demo/core/usecase/usecase.dart';
import 'package:bloc_test_demo/features/home/domin/entities/sigin_entities.dart';
import 'package:bloc_test_demo/features/home/domin/repositores/sigin_repositores.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignInPrams extends Equatable {
  final String? email;
  final String? password;

  const SignInPrams({this.email,this.password});

  @override
 List<Object?> get props => [email,password] ;
}


class SigninUseca extends Usecase<Either<Failure,SignInResponse>,SignInPrams>{
  SignInRepository signInRepository;

   SigninUseca({ required this.signInRepository});

  @override
  Future<Either<Failure,SignInResponse>>call(SignInPrams prams)async{

    return await signInRepository.signIn(email: prams.email ?? "", password: prams.password ?? "");

  }



}