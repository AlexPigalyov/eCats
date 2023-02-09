class OpenOrderByUserResponseRequestModel {
  OpenOrderByUserResponseRequestModel(
      {required this.id,
      required this.pair,
      required this.createDate,
      required this.price,
      required this.amount,
      required this.total,
      required this.createUserId,
      required this.isBuy});

  OpenOrderByUserResponseRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        pair = json['pair'],
        createDate = DateTime.parse(json['createDate']),
        price =
            json['price'] == null ? 0 : double.parse(json['price'].toString()),
        amount = json['amount'] == null
            ? 0
            : double.parse(json['amount'].toString()),
        total =
            json['total'] == null ? 0 : double.parse(json['total'].toString()),
        createUserId = json['createUserId'],
        isBuy = json['isBuy'];

  int id;
  String pair;
  DateTime createDate;
  double price;
  double amount;
  double total;
  String createUserId;
  bool isBuy;
}
