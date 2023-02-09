class OrderByDescPriceOrderBookResponseRequest {
  OrderByDescPriceOrderBookResponseRequest(
      {required this.id,
      required this.price,
      required this.amount,
      required this.total});

  OrderByDescPriceOrderBookResponseRequest.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? json['Id'],
        price = (json['price'] ?? json['Price']) == null
            ? 0
            : double.parse((json['price'] ?? json['Price']).toString()),
        amount = (json['amount'] ?? json['Amount']) == null
            ? 0
            : double.parse((json['amount'] ?? json['Amount']).toString()),
        total = (json['total'] ?? json['Total']) == null
            ? 0
            : double.parse((json['total'] ?? json['Total']).toString());

  int id;
  double price;
  double amount;
  double total;
}
