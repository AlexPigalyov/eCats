import 'package:ecats/models/requests/orders/closed_order_response_request_model.dart';
import 'package:ecats/models/requests/orders/open_order_by_user_response_request_model.dart';
import 'package:ecats/models/requests/orders/order_by_desc_price_orderbook_response_request_model.dart';
import 'package:ecats/models/requests/wallets/wallet_request_model.dart';

class CryptoTradeResponseRequestModel {
  CryptoTradeResponseRequestModel({
    required this.userId,
    required this.userWallets,
    required this.firstWallet,
    required this.secondWallet,
    required this.marketTrades,
    required this.userOpenOrders,
    required this.buyOrderBook,
    required this.sellOrderBook,
    required this.pair,
    required this.pairHeader,
    required this.firstCurrency,
    required this.secondCurrency,
  });

  CryptoTradeResponseRequestModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        userWallets = (json['userWallets'] as List<dynamic>)
            .map((userWallet) => WalletRequestModel.fromJson(userWallet))
            .toList(),
        firstWallet = WalletRequestModel.fromJson(json['firstWallet']),
        secondWallet = WalletRequestModel.fromJson(json['secondWallet']),
        marketTrades = (json['marketTrades'] as List<dynamic>)
            .map((marketTrade) =>
                ClosedOrderResponseRequestModel.fromJson(marketTrade))
            .toList(),
        userOpenOrders = (json['userOpenOrders'] as List<dynamic>)
            .map((userOpenOrder) =>
                OpenOrderByUserResponseRequestModel.fromJson(userOpenOrder))
            .toList(),
        buyOrderBook = (json['buyOrderBook'] as List<dynamic>)
            .map((buyOrder) =>
                OrderByDescPriceOrderBookResponseRequest.fromJson(buyOrder))
            .toList(),
        sellOrderBook = (json['sellOrderBook'] as List<dynamic>)
            .map((sellOrder) =>
                OrderByDescPriceOrderBookResponseRequest.fromJson(sellOrder))
            .toList(),
        pair = json['pair'],
        pairHeader = json['pairHeader'],
        firstCurrency = json['firstCurrency'],
        secondCurrency = json['secondCurrency'];

  String userId;
  List<WalletRequestModel> userWallets;
  WalletRequestModel firstWallet;
  WalletRequestModel secondWallet;
  List<ClosedOrderResponseRequestModel>? marketTrades;
  List<OpenOrderByUserResponseRequestModel>? userOpenOrders;
  List<OrderByDescPriceOrderBookResponseRequest>? buyOrderBook;
  List<OrderByDescPriceOrderBookResponseRequest>? sellOrderBook;
  String pair;
  String pairHeader;
  String firstCurrency;
  String secondCurrency;
}
