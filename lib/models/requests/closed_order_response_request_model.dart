class ClosedOrderResponseRequestModel {
  ClosedOrderResponseRequestModel(
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

  ClosedOrderResponseRequestModel.fromJson(Map<String, dynamic> json)
      : closedOrderId = json['closedOrderId'] ?? json['ClosedOrderId'],
        createDate = DateTime.parse(json['createDate'] ?? json['CreateDate']),
        closedDate = DateTime.parse(json['closedDate'] ?? json['ClosedDate']),
        isBuy = json['isBuy'] ?? json['IsBuy'],
        startPrice = (json['startPrice'] ?? json['StartPrice']) == null
            ? 0
            : double.parse(
                (json['startPrice'] ?? json['StartPrice']).toString()),
        difference = (json['difference'] ?? json['Difference']) == null
            ? 0
            : double.parse(
                (json['difference'] ?? json['Difference']).toString()),
        profit = (json['profit'] ?? json['Profit']) == null
            ? 0
            : double.parse((json['profit'] ?? json['Profit']).toString()),
        closedPrice = (json['closedPrice'] ?? json['ClosedPrice']) == null
            ? 0
            : double.parse(
                (json['closedPrice'] ?? json['ClosedPrice']).toString()),
        amount = (json['amount'] ?? json['Amount']) == null
            ? 0
            : double.parse((json['amount'] ?? json['Amount']).toString()),
        total = (json['total'] ?? json['Total']) == null
            ? 0
            : double.parse((json['total'] ?? json['Total']).toString()),
        status = json['volume24hUpdateDate'] ?? json['Volume24hUpdateDate'],
        createUserId = json['createUserId'] ?? json['CreateUserId'],
        boughtUserId = json['boughtUserId'] ?? json['BoughtUserId'],
        currency1 = json['currency1'] ?? json['Currency1'],
        currency2 = json['currency2'] ?? json['Currency2'],
        pairAcronim = json['pairAcronim'] ?? json['PairAcronim'];

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
  String? currency1;
  String? currency2;
  String? pairAcronim;
}
