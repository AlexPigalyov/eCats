class UserWalletResponseRequestModel {
  UserWalletResponseRequestModel({
    required this.id,
    required this.userId,
    required this.currencyAcronim,
    required this.created,
    required this.lastUpdate,
    required this.address,
    required this.value,
  });

  UserWalletResponseRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        currencyAcronim = json['currencyAcronim'],
        value =
            json['value'] == null ? 0 : double.parse(json['value'].toString()),
        created = DateTime.parse(json['created']),
        lastUpdate = DateTime.parse(json['lastUpdate']),
        address = json['address'];

  int id;
  String userId;
  String currencyAcronim;
  double value;
  DateTime created;
  DateTime lastUpdate;
  String address;
  bool selected = false;
}
