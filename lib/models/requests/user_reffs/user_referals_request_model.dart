import 'package:ecats/models/requests/request_model.dart';

class UserReferalsRequestModel implements RequestModel {
  UserReferalsRequestModel(
      {required this.userName,
      required this.email,
      required this.fullName,
      required this.registrationDate,
      required this.reffererId});

  @override
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'email': email,
        'fullName': fullName,
        'registrationDate': registrationDate,
        'reffererId': reffererId
      };

  UserReferalsRequestModel.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        email = json['email'],
        fullName = json['fullName'],
        registrationDate = DateTime.parse(json['registrationDate']),
        reffererId = json['reffererId'];

  String userName;
  String email;
  String fullName;
  DateTime registrationDate;
  String reffererId;
  bool selected = false;
}
