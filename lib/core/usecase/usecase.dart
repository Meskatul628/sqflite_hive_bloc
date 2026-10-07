
import 'package:equatable/equatable.dart';

abstract class Usecase<TypeData,Prams>{

  Future<TypeData>call(Prams prams) ;
}


class NoPrams extends Equatable {
  const NoPrams();

  @override
  List<Object?> get props => [] ;
}