import 'package:ecats/models/requests/request_model.dart';

class SendCoinsRequestModel extends RequestModel {
  SendCoinsRequestModel(
      {required this.inputTextIdentifier,
      required this.currency,
      required this.amount,
      required this.comment});

  String inputTextIdentifier;
  String currency;
  String amount;
  String comment;

  @override
  Map<String, dynamic> toJson() => {
        'status': '',
        'commission': 0,
        'inputTextIdentifier': inputTextIdentifier,
        'currency': currency,
        'balance': 0,
        'amount': amount,
        'comment': comment
      };
}
