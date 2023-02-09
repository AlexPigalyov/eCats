import 'package:ecats/models/requests/currency_response_request_model.dart';
import 'package:ecats/models/requests/wallets/income_wallet_response_request_model.dart';
import 'package:ecats/models/requests/wallets/user_wallet_response_request_model.dart';

class UserWalletsResponseRequestModel {
  UserWalletsResponseRequestModel(
      {required this.currencies,
      required this.userIncomeWallets,
      required this.userWallets});

  List<UserWalletResponseRequestModel> emptyUserWallets() {
    return [];
  }

  List<IncomeWalletResponseRequestModel> emptyIncomeUserWallets() {
    return [];
  }

  UserWalletsResponseRequestModel.fromJson(Map<String, dynamic> json)
      : currencies = (json['currencies'] as List<dynamic>)
            .map((currency) => CurrencyResponseRequestModel.fromJson(currency))
            .toList(),
        userIncomeWallets = (json['userIncomeWallets'] as List<dynamic>)
            .map((userIncomeWallet) =>
                IncomeWalletResponseRequestModel.fromJson(userIncomeWallet))
            .toList(),
        userWallets = (json['userWallets'] as List<dynamic>)
            .map((wallet) => UserWalletResponseRequestModel.fromJson(wallet))
            .toList();

  List<CurrencyResponseRequestModel>? currencies;
  List<IncomeWalletResponseRequestModel>? userIncomeWallets;
  List<UserWalletResponseRequestModel>? userWallets;
}
