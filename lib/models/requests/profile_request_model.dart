import 'package:ecats/models/requests/request_model.dart';

class ProfileRequestModel implements RequestModel {
  UserInfoTableModel userInfo;
  String username;
  List<EventTableModel>? lastFiveEvents;
  String email;
  String? phoneNumber;
  List<NotEmptyValueWalletModel>? notEmptyWallets;
  bool isMyProfile;
  String userNumber;

  ProfileRequestModel(
      {required this.userInfo,
      required this.username,
      this.lastFiveEvents,
      required this.email,
      this.phoneNumber,
      this.notEmptyWallets,
      required this.isMyProfile,
      required this.userNumber});

  ProfileRequestModel.fromJson(Map<String, dynamic> json)
      : userInfo = UserInfoTableModel.fromJson(
            (json['userInfo'] as Map<String, dynamic>)),
        username = json['username'],
        lastFiveEvents = (json['lastFiveEvents'] as List<dynamic>)
            ?.map((event) => EventTableModel.fromJson(event))
            .toList(),
        email = json['email'],
        phoneNumber = json['phoneNumber'],
        notEmptyWallets =
            (json['notEmptyWallets'] as List<Map<String, dynamic>>)
                ?.map((wallet) => NotEmptyValueWalletModel.fromJson(wallet))
                .toList(),
        isMyProfile = json['isMyProfile'],
        userNumber = json['userNumber'];

  @override
  Map<String, dynamic> toJson() => {
        'userInfo': userInfo.toJson(),
        'username': username,
        'lastFiveEvents': lastFiveEvents == null
            ? []
            : lastFiveEvents?.map((e) => e.toJson()).toList(),
        'email': email,
        'phoneNumber': phoneNumber,
        'notEmptyWallets': notEmptyWallets == null
            ? []
            : notEmptyWallets?.map((e) => e.toJson()).toList(),
        'isMyProfile': isMyProfile,
        'userNumber': userNumber
      };
}

class UserInfoTableModel {
  String? userId;
  String? profilePhotoPath;
  String? fullName;
  String? aboutMe;
  String? refferalId;
  String? facebookLink;
  String? instagramLink;
  String? skypeLink;
  String? twitterLink;
  String? linkedinLink;
  String? githubLink;
  String? location;
  DateTime registrationDate;

  UserInfoTableModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        profilePhotoPath = json['profilePhotoPath'],
        fullName = json['fullName'],
        aboutMe = json['aboutMe'],
        refferalId = json['refferalId'],
        facebookLink = json['facebookLink'],
        instagramLink = json['instagramLink'],
        skypeLink = json['skypeLink'],
        twitterLink = json['twitterLink'],
        githubLink = json['githubLink'],
        location = json['location'],
        registrationDate = DateTime.parse(json['registrationDate']);

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'profilePhotoPath': profilePhotoPath,
        'fullName': fullName,
        'aboutMe': aboutMe,
        'refferalId': refferalId,
        'facebookLink': facebookLink,
        'instagramLink': instagramLink,
        'skypeLink': skypeLink,
        'twitterLink': twitterLink,
        'githubLink': githubLink,
        'location': location,
        'registrationDate': registrationDate.toString()
      };

  UserInfoTableModel(
      {this.userId,
      this.profilePhotoPath,
      this.fullName,
      this.aboutMe,
      this.refferalId,
      this.facebookLink,
      this.instagramLink,
      this.skypeLink,
      this.twitterLink,
      this.linkedinLink,
      this.githubLink,
      this.location,
      required this.registrationDate});
}

class EventTableModel {
  int id;
  String userId;
  int type;
  double? value;
  double? startBalance;
  double? resultBalance;
  double? platformCommission;
  String comment;
  DateTime whenDate;
  String currencyAccronim;

  EventTableModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        type = json['type'],
        value = json['value'] == null ? 0 : double.parse(json['value'].toString()),
        startBalance = json['startBalance'] == null ? 0 : double.parse(json['startBalance'].toString()),
        resultBalance = json['resultBalance'] == null
            ? 0
            : double.parse(json['resultBalance'].toString()),
        platformCommission = json['platformCommission'] == null ? 0 : double.parse(json['platformCommission'].toString()),
        comment = json['comment'],
        whenDate = DateTime.parse(json['whenDate']),
        currencyAccronim = json['currencyAccronim'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'type': type,
        'value': value,
        'startBalance': startBalance,
        'resultBalance': resultBalance,
        'platformCommission': platformCommission,
        'comment': comment,
        'whenDate': whenDate,
        'currencyAccronim': currencyAccronim
      };

  EventTableModel(
      {required this.id,
      required this.userId,
      required this.type,
      this.value,
      this.startBalance,
      this.resultBalance,
      this.platformCommission,
      required this.comment,
      required this.whenDate,
      required this.currencyAccronim});
}

class NotEmptyValueWalletModel {
  String userId;
  String currencyAcronim;
  double value;

  NotEmptyValueWalletModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        currencyAcronim = json['currencyAcronim'],
        value = double.parse(json['value'].toString());

  Map<String, dynamic> toJson() =>
      {'userId': userId, 'currencyAcronim': currencyAcronim, 'value': value};

  NotEmptyValueWalletModel(
      {required this.userId,
      required this.currencyAcronim,
      required this.value});
}
