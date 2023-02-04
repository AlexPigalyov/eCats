import 'package:ecats/models/requests/request_model.dart';

class EventRequestModel implements RequestModel {
  EventRequestModel(
      {required this.id,
      required this.userId,
      required this.type,
      required this.value,
      required this.startBalance,
      required this.resultBalance,
      required this.platformCommission,
      required this.comment,
      required this.whenDate,
      required this.currencyAcronim});

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'type': type,
        'value': value,
        'startBalance': startBalance,
        'resultBalance': resultBalance,
        'platformCommission': platformCommission,
        'comment': comment,
        'whenDate': whenDate.toString(),
        'currencyAcronim': currencyAcronim,
      };

  EventRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        type = json['type'],
        value = json['value'] == null
            ? null
            : double.parse(json['value'].toString()),
        startBalance = json['startBalance'] == null
            ? null
            : double.parse(json['startBalance'].toString()),
        resultBalance = json['resultBalance'] == null
            ? null
            : double.parse(json['resultBalance'].toString()),
        platformCommission = json['platformCommission'] == null
            ? null
            : double.parse(json['platformCommission'].toString()),
        comment = json['comment'],
        whenDate = DateTime.parse(json['whenDate']),
        currencyAcronim = json['currencyAcronim'];

  int id;
  String userId;
  int type;
  double? value;
  double? startBalance;
  double? resultBalance;
  double? platformCommission;
  String comment;
  DateTime whenDate;
  String currencyAcronim;
  bool selected = false;
}
