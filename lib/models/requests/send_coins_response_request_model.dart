class SendCoinsResponseRequestModel {
  SendCoinsResponseRequestModel(
      {required this.currency, required this.balance, required this.commision});

  SendCoinsResponseRequestModel.fromJson(Map<String, dynamic> json)
      : currency = json['currency'],
        balance = json['balance'] == null
            ? 0
            : double.parse(json['balance'].toString()),
        commision = json['commision'] == null
            ? 0
            : double.parse(json['commision'].toString());

  String currency;
  double balance;
  double commision;
}
