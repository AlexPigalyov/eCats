import 'package:ecats/models/requests/request_model.dart';

class RegisterRequestModel implements RequestModel {
  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.refId
  });

  @override
  Map<String, dynamic> toJson() =>
  {
    'email': email,
    'password': password,
    'confirmPassword': confirmPassword,
    'refId': refId
  };
  /*
  For next patches
  @Required(error: 'Email is required.')
  @Email(error: 'Email should contains domain.')
  String email;
  
  @Required(error: 'Password is required.')
  @StringLength(min: 1, max: 100, error: 'Password must be at least 1 and at max 100 characters long.')
  String password;

  @Required(error: 'Confirm password is required.')
  @EqualToString(valueToCompareOnProperty: 'password', error: 'The password and confirmation password do not match.')
  String passwordConfirm;
  */
  String email;
  String password;
  String confirmPassword;
  int? refId;
}