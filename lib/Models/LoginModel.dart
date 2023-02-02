import 'package:flutter_model_form_validation/flutter_model_form_validation.dart';

class LoginModel {
  LoginModel({
    required this.email,
    required this.password,
    required this.rememberMe
  });

  LoginModel.createDefault() :
    email = '',
    password = '',
    rememberMe = false;

  String email;
  String password;
  bool rememberMe;
}