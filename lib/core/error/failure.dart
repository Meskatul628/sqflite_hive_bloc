import 'package:equatable/equatable.dart';

class Failure extends Equatable{

   String message;
   Failure({required this.message});

  @override
  List<Object?> get props => [message];

}

class CacheFailure extends Failure{

   CacheFailure({super.message = "Cache Failure"});
}

class ServerFailure extends Failure{
  ServerFailure({super.message = "Server Failure"});

}

class NetworkFailure extends Failure{

  NetworkFailure({super.message = "No Internet connection , Please try again"});
}

class UnothorizedFailure extends Failure {

  UnothorizedFailure({super.message = "Unothorized Failure"});
}
