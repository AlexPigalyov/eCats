class PairResponseRequestModel {
  PairResponseRequestModel({
    required this.id,
    required this.currency1,
    required this.currency2,
    required this.currency2Postfix,
    required this.order,
    required this.created,
    required this.header,
    required this.acronim,
    required this.price,
    required this.priceUpdateDate,
    required this.change1m,
    required this.change1mUpdateDate,
    required this.change15m,
    required this.change15mUpdateDate,
    required this.change24h,
    required this.change24hUpdateDate,
    required this.change1h,
    required this.change1hUpdateDate,
    required this.volume24h,
    required this.volume24hUpdateDate,
    required this.sQLTableName,
    required this.imgUrl,
  });

  PairResponseRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        currency1 = json['currency1'],
        currency2 = json['currency2'],
        currency2Postfix = json['currency2Postfix'],
        order = json['order'],
        created = DateTime.parse(json['created']),
        header = json['header'],
        acronim = json['acronim'],
        price =
            json['price'] == null ? 0 : double.parse(json['price'].toString()),
        priceUpdateDate = DateTime.parse(json['priceUpdateDate']),
        change1m = json['change1m'] == null
            ? 0
            : double.parse(json['change1m'].toString()),
        change1mUpdateDate = DateTime.parse(json['change1mUpdateDate']),
        change15m = json['change15m'] == null
            ? 0
            : double.parse(json['change15m'].toString()),
        change15mUpdateDate = DateTime.parse(json['change15mUpdateDate']),
        change24h = json['change24h'] == null
            ? 0
            : double.parse(json['change24h'].toString()),
        change24hUpdateDate = DateTime.parse(json['change24hUpdateDate']),
        change1h = json['change1h'] == null
            ? 0
            : double.parse(json['change1h'].toString()),
        change1hUpdateDate = DateTime.parse(json['change1hUpdateDate']),
        volume24h = json['volume24h'] == null
            ? 0
            : double.parse(json['volume24h'].toString()),
        volume24hUpdateDate = DateTime.parse(json['volume24hUpdateDate']),
        sQLTableName = json['sQLTableName'],
        imgUrl = json['imgUrl'];

  int id;
  String currency1;
  String currency2;
  String currency2Postfix;
  int order;
  DateTime created;
  String header;
  String acronim;
  double price;
  DateTime priceUpdateDate;
  double change1m;
  DateTime change1mUpdateDate;
  double change15m;
  DateTime change15mUpdateDate;
  double change24h;
  DateTime change24hUpdateDate;
  double change1h;
  DateTime change1hUpdateDate;
  double volume24h;
  DateTime volume24hUpdateDate;
  String sQLTableName;
  String imgUrl;
  bool selected = false;
}
