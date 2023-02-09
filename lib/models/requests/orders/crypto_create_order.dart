import 'package:ecats/models/requests/request_model.dart';

class CryptoCreateOrder implements RequestModel {
  CryptoCreateOrder(
      {required this.price,
      required this.amount,
      required this.isBuy,
      required this.pair});

  @override
  Map<String, dynamic> toJson() =>
      {'price': price, 'amount': amount, 'isBuy': isBuy, 'pair': pair};

  String price;
  String amount;
  bool isBuy;
  String pair;
}
