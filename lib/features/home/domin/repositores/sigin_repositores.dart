import 'package:bloc_test_demo/core/error/failure.dart';
import 'package:bloc_test_demo/features/home/domin/entities/sigin_entities.dart';
import 'package:dartz/dartz.dart';

abstract class SignInRepository {
  Future<Either<Failure, SignInResponse>> signIn(
      {required String email, required String password});
}