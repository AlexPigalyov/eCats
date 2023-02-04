import 'package:ecats/models/requests/request_model.dart';

class LoginRequestModel implements RequestModel {
  LoginRequestModel(
      {required this.login, required this.password, required this.rememberMe});

  LoginRequestModel.createDefault()
      : login = '',
        password = '',
        rememberMe = false;

  @override
  Map<String, dynamic> toJson() =>
      {'login': login, 'password': password, 'rememberMe': rememberMe};

  String login;
  String password;
  bool rememberMe;
}
