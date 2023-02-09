import 'package:ecats/models/requests/asp_net_user_request_model.dart';
import 'package:ecats/models/requests/request_model.dart';
import 'package:ecats/models/requests/shared/paged_request_model.dart';
import 'package:ecats/models/requests/user_reffs/user_referals_request_model.dart';

class UserRefferalRequestModel implements RequestModel {
  UserRefferalRequestModel(
      {this.user, this.userRefferal, this.myRefferals, this.paged});

  @override
  Map<String, dynamic> toJson() => {
        'user': user == null ? {} : user?.toJson(),
        'userRefferal': userRefferal == null
            ? []
            : userRefferal?.map((e) => e.toJson()).toList(),
        'myRefferals': myRefferals == null
            ? []
            : myRefferals?.map((e) => e.toJson()).toList(),
        'paged': paged == null ? {} : paged?.toJson()
      };

  UserRefferalRequestModel.fromJson(Map<String, dynamic> json)
      : user = json['user'] == null
            ? AspNetUserRequestModel.empty()
            : AspNetUserRequestModel.fromJson(json['user']),
        userRefferal = (json['userRefferal'] as List<dynamic>)
            ?.map((userRefferal) =>
                UserReferalsRequestModel.fromJson(userRefferal))
            .toList(),
        myRefferals = (json['myRefferals'] as List<dynamic>)
            ?.map((myRefferer) => UserReferalsRequestModel.fromJson(myRefferer))
            .toList(),
        paged = json['pageViewModel'] == null
            ? PagedRequestModel.empty()
            : PagedRequestModel.fromJson(json['pageViewModel']);

  AspNetUserRequestModel? user;
  List<UserReferalsRequestModel>? userRefferal;
  List<UserReferalsRequestModel>? myRefferals;
  PagedRequestModel? paged;
  bool selected = false;
}
