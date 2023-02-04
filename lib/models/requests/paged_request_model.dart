import 'package:ecats/models/requests/request_model.dart';

class PagedRequestModel implements RequestModel {
  PagedRequestModel(
      {required this.pageNumber,
      required this.totalPages,
      required this.hasPreviousPage,
      required this.hasNextPage});

  PagedRequestModel.empty() {
    pageNumber = 0;
    totalPages = 0;
    hasNextPage = false;
    hasPreviousPage = false;
  }

  @override
  Map<String, dynamic> toJson() => {
        'pageNumber': pageNumber,
        'totalPages': totalPages,
        'hasPreviousPage': hasPreviousPage,
        'hasNextPage': hasNextPage
      };

  PagedRequestModel.fromJson(Map<String, dynamic> json)
      : pageNumber = json['pageNumber'],
        totalPages = json['totalPages'],
        hasPreviousPage = json['hasPreviousPage'],
        hasNextPage = json['hasNextPage'];

  int? pageNumber;
  int? totalPages;
  bool? hasPreviousPage;
  bool? hasNextPage;
}
