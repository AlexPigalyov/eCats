import 'package:ecats/models/requests/request_model.dart';

class GeneralWithdrawRequestModel implements RequestModel {
  GeneralWithdrawRequestModel(
      {required this.amount, required this.currency, required this.address});

  @override
  Map<String, dynamic> toJson() => {
        'status': status,
        'amountMin': amountMin,
        'commission': commission,
        'amount': amount,
        'isApproximate': isApproximate,
        'currency': currency,
        'balance': balance,
        'address': address,
        'comment': comment
      };

  GeneralWithdrawRequestModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        amountMin = json['amountMin'] == null
            ? 0
            : double.parse(json['amountMin'].toString()),
        commission = json['commission'] == null
            ? 0
            : double.parse(json['commission'].toString()),
        isApproximate = json['isApproximate'],
        currency = json['currency'],
        balance = json['balance'] == null
            ? 0
            : double.parse(json['balance'].toString()),
        address = json['address'],
        amount = json['amount'],
        comment = json['comment'];

  String? status;
  double? amountMin;
  double? commission;
  bool? isApproximate;
  String? currency;
  double? balance;
  String? address;
  String? amount;
  String? comment;
}
