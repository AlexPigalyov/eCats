import 'package:ecats/models/requests/request_model.dart';

class AspNetUserRequestModel implements RequestModel {
  AspNetUserRequestModel(
      {required this.id,
      required this.number,
      required this.userName,
      required this.email});

  AspNetUserRequestModel.empty() {
    id = '';
    number = 0;
    userName = '';
    email = '';
  }

  @override
  Map<String, dynamic> toJson() =>
      {'id': id, 'number': number, 'userName': userName, 'email': email};

  AspNetUserRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        number = json['number'],
        userName = json['userName'],
        email = json['email'];

  String? id;
  int? number;
  String? userName;
  String? email;
}
