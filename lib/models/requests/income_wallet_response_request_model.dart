class IncomeWalletResponseRequestModel {
  IncomeWalletResponseRequestModel({
    required this.id,
    required this.userId,
    required this.currencyAcronim,
    required this.created,
    required this.lastUpdate,
    required this.address,
    required this.addressLabel,
  });

  IncomeWalletResponseRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        currencyAcronim = json['currencyAcronim'],
        created = DateTime.parse(json['created']),
        lastUpdate = DateTime.parse(json['lastUpdate']),
        address = json['address'],
        addressLabel = json['addressLabel'];

  int id;
  String userId;
  String currencyAcronim;
  DateTime created;
  DateTime lastUpdate;
  String address;
  String addressLabel;
  bool selected = false;
}
