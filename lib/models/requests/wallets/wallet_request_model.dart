import 'package:ecats/models/requests/request_model.dart';

class WalletRequestModel implements RequestModel {
  WalletRequestModel(
      {required this.id,
      required this.userId,
      required this.currencyAcronim,
      required this.value,
      required this.created,
      required this.lastUpdate,
      required this.address});

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'currencyAcronim': currencyAcronim,
        'value': value,
        'created': created,
        'lastUpdate': lastUpdate,
        'address': address
      };

  WalletRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        currencyAcronim = json['currencyAcronim'],
        value = json['value'].toString().contains('.')
            ? json['value']
            : double.parse('${json['value']}.0'),
        created = DateTime.parse(json['created']),
        lastUpdate = DateTime.parse(json['lastUpdate']),
        address = json['address'];

  int? id;
  String? userId;
  String? currencyAcronim;
  double? value;
  DateTime? created;
  DateTime? lastUpdate;
  String? address;
  bool selected = false;
}
