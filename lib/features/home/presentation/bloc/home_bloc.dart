import 'package:bloc/bloc.dart';
import 'package:bloc_test_demo/features/home/domin/usecash/signin_useca.dart';
import 'package:bloc_test_demo/features/home/presentation/bloc/home_event.dart';
import 'package:bloc_test_demo/features/home/presentation/bloc/home_state.dart';
import 'package:flutter/cupertino.dart';

class SignInBloc extends Bloc<SignInEvent,SignInState>{
      SigninUseca signinUseca;

   SignInBloc({required this.signinUseca}) : super(const  SignInInitail()){
     on<LoginEvent>((event,emit)async{
       emit(const SignInLoading());
       
        final result = await signinUseca(SignInPrams(email: event.email?.trim(),password: event.password));
        
        result.fold(
          (failure) => emit(SignInFailure(message: failure.message ?? "Unknown error")),
          (response) => emit(SingInsuscess(signInResponse: response)),
        );
        
       debugPrint("login emil is a ${event.email}");
       debugPrint("login password is a ${event.password}");
     });

  }
}