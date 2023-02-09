import 'package:ecats/models/requests/request_model.dart';

class CreateWalletRequestModel extends RequestModel {
  CreateWalletRequestModel({required this.selecCurrency});

  String selecCurrency;

  @override
  Map<String, dynamic> toJson() => {'selectCurrency': selecCurrency};
}
