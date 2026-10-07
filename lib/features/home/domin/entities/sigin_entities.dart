class SignInResponse {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  SignInResponse({this.statusCode, this.success, this.message, this.data});
}

class Data {
  String? accessToken;
  String? refreshToken;
  User? user;

  Data({this.accessToken, this.refreshToken, this.user});
}

class User {
  String? id;
  String? name;
  String? email;
  String? role;
  String? profilePicture;
  String? sizeUnit;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.profilePicture,
    this.sizeUnit,
  });
}
