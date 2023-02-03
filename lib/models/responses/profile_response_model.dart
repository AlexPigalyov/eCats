
import 'package:decimal/decimal.dart';

class ProfileResponseModel {
  UserInfoTableModel userInfo;
  String username;
  List<EventTableModel>? lastFiveEvents;
  String email;
  String? phoneNumber;
  List<NotEmptyValueWalletModel>? notEmptyWallets;
  bool isMyProfile;
  String userNumber;

  ProfileResponseModel({
    required this.userInfo,
    required this.username,
    this.lastFiveEvents,
    required this.email,
    this.phoneNumber,
    this.notEmptyWallets,
    required this.isMyProfile,
    required this.userNumber
  });

  ProfileResponseModel.fromJson(Map<String, dynamic> json) :
    userInfo = UserInfoTableModel.fromJson((json['userInfo'] as Map<String, dynamic>)),
    username = json['username'],
    lastFiveEvents = (json['lastFiveEvents'] as List<dynamic>)?.map((event) => EventTableModel.fromJson(event)).toList(),
    email = json['email'],
    phoneNumber = json['phoneNumber'],
    notEmptyWallets = (json['notEmptyWallets'] as List<Map<String, dynamic>>)?.map((wallet) => NotEmptyValueWalletModel.fromJson(wallet)).toList(),
    isMyProfile = json['isMyProfile'],
    userNumber = json['userNumber'];
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
  String registrationDate;

  UserInfoTableModel.fromJson(Map<String, dynamic> json) :
    userId = json['userId'],
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
    registrationDate = json['registrationDate'];

  UserInfoTableModel({
    this.userId,
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
    required this.registrationDate
  });
}

class EventTableModel {
  int id;
  String userId;
  int type;
  Decimal? value;
  Decimal? startBalance;
  Decimal? resultBalance;
  Decimal? platformCommission;
  String comment;
  String whenDate;
  String currencyAccronim;

  EventTableModel.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    userId = json['userId'],
    type = json['type'],
    value = json['value'],
    startBalance = json['startBalance'],
    resultBalance = json['resultBalance'],
    platformCommission = json['platformCommission'],
    comment = json['comment'],
    whenDate = json['whenDate'],
    currencyAccronim = json['currencyAccronim'];

  EventTableModel({
    required this.id,
    required this.userId,
    required this.type,
    this.value,
    this.startBalance,
    this.resultBalance,
    this.platformCommission,
    required this.comment,
    required this.whenDate,
    required this.currencyAccronim
  });
}

class NotEmptyValueWalletModel {
  String userId;
  String currencyAcronim;
  Decimal value;

  NotEmptyValueWalletModel.fromJson(Map<String, dynamic> json) :
    userId = json['userId'],
    currencyAcronim = json['currencyAcronim'],
    value = json['value'];

  NotEmptyValueWalletModel({
    required this.userId,
    required this.currencyAcronim,
    required this.value
  });
}