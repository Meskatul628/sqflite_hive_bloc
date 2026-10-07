import 'package:bloc_test_demo/core/error/failure.dart';
import 'package:bloc_test_demo/features/home/domin/entities/sigin_entities.dart';
import 'package:dartz/dartz.dart';

import '../../domin/repositores/sigin_repositores.dart';
import '../datasourch/signin_remote_datasourch.dart';

class SigninRepositoresImpl implements SignInRepository{
  final SigninRemoteDatasourch signinRemoteDatasourch;
  SigninRepositoresImpl({required this.signinRemoteDatasourch});


  @override

  Future<Either<Failure,SignInResponse>>signIn({required String email, required String password})async{
     try{
       final response = await signinRemoteDatasourch.singIn(email: email, password: password);
       return right(response);
     }catch(e){
       return left(ServerFailure(message:e.toString()));
     }
  }



}