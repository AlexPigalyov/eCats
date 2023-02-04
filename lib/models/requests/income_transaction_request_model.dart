import 'package:ecats/models/requests/request_model.dart';

class EventRequestModel implements RequestModel {
  EventRequestModel(
      {required this.id,
      required this.currencyAcronim,
      required this.transactionHash,
      required this.amount,
      required this.transactionFee,
      this.platformCommission,
      required this.fromAdress,
      required this.toAddress,
      required this.createdDate,
      required this.date,
      required this.userId,
      required this.walletid});

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'currencyAcronim': currencyAcronim,
        'transactionHash': transactionHash,
        'amount': amount,
        'transactionFee': transactionFee,
        'platformCommission': platformCommission,
        'fromAdress': fromAdress,
        'toAddress': toAddress,
        'createdDate': createdDate,
        'date': date,
        'userId': userId,
        'walletid': walletid
      };

  EventRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        currencyAcronim = json['currencyAcronim'],
        transactionHash = json['transactionHash'],
        amount = json['amount'],
        transactionFee = double.parse(json['transactionFee'].toString()),
        platformCommission = json['platformCommission'] == null
            ? 0
            : double.parse(json['platformCommission'].toString()),
        fromAdress = json['fromAddress'],
        toAddress = json['toAddress'],
        createdDate = DateTime.parse(json['createdDate']),
        date = double.parse(json['date'].toString()),
        userId = json['userId'],
        walletid = json['walletid'];

  int id;
  String currencyAcronim;
  String transactionHash;
  double amount;
  double transactionFee;
  double? platformCommission;
  String fromAdress;
  String toAddress;
  DateTime createdDate;
  double date;
  String userId;
  int walletid;
  bool selected = false;
}
