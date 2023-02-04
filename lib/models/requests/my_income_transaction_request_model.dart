import 'package:ecats/models/requests/income_transaction_request_model.dart';
import 'package:ecats/models/requests/paged_request_model.dart';
import 'package:ecats/models/requests/request_model.dart';

class MyIncomeTransactionRequestModel implements RequestModel {
  MyIncomeTransactionRequestModel({this.incomeTransactions, this.paged});

  @override
  Map<String, dynamic> toJson() => {
        'incomeTransactions': incomeTransactions == null
            ? []
            : incomeTransactions?.map((e) => e.toJson()).toList(),
        'paged': paged == null ? {} : paged?.toJson()
      };

  MyIncomeTransactionRequestModel.fromJson(Map<String, dynamic> json)
      : incomeTransactions = (json['incomeTransactions'] as List<dynamic>)
            .map((incomeTransaction) =>
                EventRequestModel.fromJson(incomeTransaction))
            .toList(),
        paged = json['pageViewModel'] == null
            ? PagedRequestModel.empty()
            : PagedRequestModel.fromJson(json['pageViewModel']);

  List<EventRequestModel>? incomeTransactions;
  PagedRequestModel? paged;
}
