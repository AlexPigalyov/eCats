import 'package:flutter_model_form_validation/flutter_model_form_validation.dart';

class RegisterModel {
  RegisterModel({
    required this.email,
    required this.password,
    required this.passwordConfirm
  });

  @Required(error: 'Email is required.')
  @Email(error: 'Email should contains domain.')
  String email;
  
  @Required(error: 'Password is required.')
  @StringLength(min: 1, max: 100, error: 'Password must be at least 1 and at max 100 characters long.')
  String password;

  @Required(error: 'Confirm password is required.')
  @EqualToString(valueToCompareOnProperty: 'password', error: 'The password and confirmation password do not match.')
  String passwordConfirm;
}