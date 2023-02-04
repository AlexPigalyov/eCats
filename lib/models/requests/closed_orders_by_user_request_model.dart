import 'package:ecats/models/requests/request_model.dart';

class ClosedOrderByUserRequestModel implements RequestModel {
  ClosedOrderByUserRequestModel(
      {required this.closedOrderId,
      required this.createDate,
      required this.closedDate,
      required this.isBuy,
      required this.startPrice,
      required this.difference,
      required this.profit,
      required this.closedPrice,
      required this.amount,
      required this.total,
      required this.status,
      required this.createUserId,
      required this.boughtUserId,
      required this.currency1,
      required this.currency2,
      required this.pairAcronim});

  @override
  Map<String, dynamic> toJson() => {
        'closedOrderId': closedOrderId,
        'createDate': createDate.toString(),
        'closedDate': closedDate.toString(),
        'isBuy': isBuy,
        'startPrice': startPrice,
        'difference': difference,
        'profit': profit,
        'closedPrice': closedPrice,
        'amount': amount,
        'total': total,
        'status': status,
        'createUserId': createUserId,
        'boughtUserId': boughtUserId,
        'currency1': currency1,
        'currency2': currency2,
        'pairAcronim': pairAcronim,
      };

  ClosedOrderByUserRequestModel.fromJson(Map<String, dynamic> json)
      : closedOrderId = json['closedOrderId'],
        createDate = DateTime.parse(json['createDate']),
        closedDate = DateTime.parse(json['closedDate']),
        isBuy = json['isBuy'],
        startPrice = double.parse(json['startPrice'].toString()),
        difference = double.parse(json['difference'].toString()),
        profit = double.parse(json['profit'].toString()),
        closedPrice = double.parse(json['closedPrice'].toString()),
        amount = double.parse(json['amount'].toString()),
        total = double.parse(json['total'].toString()),
        status = json['status'],
        createUserId = json['createUserId'],
        boughtUserId = json['boughtUserId'],
        currency1 = json['currency1'],
        currency2 = json['currency2'],
        pairAcronim = json['pairAcronim'];

  int closedOrderId;
  DateTime createDate;
  DateTime closedDate;
  bool isBuy;
  double startPrice;
  double difference;
  double profit;
  double closedPrice;
  double amount;
  double total;
  int status;
  String createUserId;
  String boughtUserId;
  String currency1;
  String currency2;
  String pairAcronim;
  bool selected = false;
}
