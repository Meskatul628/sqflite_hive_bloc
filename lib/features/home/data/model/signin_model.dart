import 'package:bloc_test_demo/features/home/domin/entities/sigin_entities.dart';

class SignInModel extends SignInResponse {
  SignInModel({
    super.statusCode,
    super.success,
    super.message,
    DataModel? super.data,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? DataModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['statusCode'] = statusCode;
    dataMap['success'] = success;
    dataMap['message'] = message;
    if (data != null) {
      dataMap['data'] = (data as DataModel).toJson();
    }
    return dataMap;
  }
}

class DataModel extends Data {
  DataModel({
    super.accessToken,
    super.refreshToken,
    UserModel? super.user,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['accessToken'] = accessToken;
    dataMap['refreshToken'] = refreshToken;
    if (user != null) {
      dataMap['user'] = (user as UserModel).toJson();
    }
    return dataMap;
  }
}

class UserModel extends User {
  UserModel({
    super.id,
    super.name,
    super.email,
    super.role,
    super.profilePicture,
    super.sizeUnit,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      profilePicture: json['profilePicture'],
      sizeUnit: json['sizeUnit'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['id'] = id;
    dataMap['name'] = name;
    dataMap['email'] = email;
    dataMap['role'] = role;
    dataMap['profilePicture'] = profilePicture;
    dataMap['sizeUnit'] = sizeUnit;
    return dataMap;
  }
}
