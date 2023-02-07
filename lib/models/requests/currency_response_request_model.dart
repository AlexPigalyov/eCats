class CurrencyResponseRequestModel {
  CurrencyResponseRequestModel({required this.acronim});

  CurrencyResponseRequestModel.fromJson(Map<String, dynamic> json)
      : acronim = json['acronim'];

  String acronim;
}
