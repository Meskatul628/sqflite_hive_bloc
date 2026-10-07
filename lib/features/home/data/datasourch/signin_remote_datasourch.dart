import 'package:bloc_test_demo/core/network/dio_client_2nd.dart';
import 'package:bloc_test_demo/features/home/data/model/signin_model.dart';
import 'package:flutter/cupertino.dart';

abstract class SigninRemoteDatasourch {
  Future<SignInModel> singIn({
    required String email,
    required String password,
  });
}

class SignRemoteDataSourceImpl implements SigninRemoteDatasourch {
  final DioClient2nd dioClient2nd;

  SignRemoteDataSourceImpl({required this.dioClient2nd});

  @override
  Future<SignInModel> singIn({
    required String email,
    required String password,
  }) async {
    final response = await dioClient2nd.dio.post(
      'auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    debugPrint("Body Data : ${response.data}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonMap = response.data is String
          ? Map<String, dynamic>.from(response.data) // just in case
          : response.data;
      return SignInModel.fromJson(jsonMap);
    } else {
      throw Exception(
        'Failed to sign in. Server responded with status code: ${response.statusCode}',
      );
    }
  }
}
