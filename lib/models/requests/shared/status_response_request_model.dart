class StatusResponseRequestModel {
  StatusResponseRequestModel({required this.status});

  StatusResponseRequestModel.fromJson(Map<String, dynamic> json)
      : status = json['status'];

  String status;
}
