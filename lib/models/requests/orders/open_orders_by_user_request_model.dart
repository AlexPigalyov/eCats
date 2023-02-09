import 'package:ecats/models/requests/request_model.dart';

class OpenOrderByUserRequestModel implements RequestModel {
  OpenOrderByUserRequestModel(
      {required this.id,
      required this.pair,
      required this.currency1,
      required this.currency2,
      required this.createDate,
      required this.price,
      required this.amount,
      required this.total,
      required this.createUserId,
      required this.isBuy});

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'pair': pair,
        'currency1': currency1,
        'currency2': currency2,
        'createDate': createDate,
        'price': price,
        'amount': amount,
        'total': total,
        'createUserId': createUserId,
        'isBuy': isBuy,
      };

  OpenOrderByUserRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        pair = json['pair'],
        currency1 = json['currency1'],
        currency2 = json['currency2'],
        createDate = DateTime.parse(json['createDate']),
        price = double.parse(json['price'].toString()),
        amount = double.parse(json['amount'].toString()),
        total = double.parse(json['total'].toString()),
        createUserId = json['createUserId'],
        isBuy = json['isBuy'];

  int id;
  String pair;
  String currency1;
  String currency2;
  DateTime createDate;
  double price;
  double amount;
  double total;
  String createUserId;
  bool isBuy;
  bool selected = false;
}
