import 'package:data_table_2/data_table_2.dart';
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/requests/user_wallet_response_request_model.dart';
import 'package:flutter/material.dart';

class WalletsByUserDataSource extends DataTableSource {
  WalletsByUserDataSource.empty(this.context) {
    userWallets = [];
  }

  WalletsByUserDataSource(this.context, this.userWallets, this.screenCallback,
      [this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]);

  late void Function(PageEnum, AppBarEnum, dynamic) screenCallback;
  final BuildContext context;
  late List<UserWalletResponseRequestModel> userWallets;
  bool hasRowTaps = false;
  bool hasRowHeightOverrides = false;
  bool hasZebraStripes = false;

  void sort<T>(
      Comparable<T> Function(UserWalletResponseRequestModel d) getField,
      bool ascending) {
    userWallets.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  @override
  DataRow getRow(int index, [Color? color]) {
    if (index >= userWallets.length) throw 'index > _userWallets.length';
    final userWallet = userWallets[index];
    return DataRow2.byIndex(
      index: index,
      selected: userWallet.selected,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      cells: [
        DataCell(Container(
          alignment: Alignment.centerLeft,
          child: Text(userWallet.currencyAcronim, textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(userWallet.value.toString(), textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(userWallet.address, textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  child: Text("Withdraw ${userWallet.currencyAcronim}"),
                  onPressed: () async {
                    screenCallback(PageEnum.Withdraw, AppBarEnum.Authorized,
                        userWallet.currencyAcronim);
                  },
                ),
                Container(margin: const EdgeInsets.only(top: 5)),
                TextButton(
                  child: Text("Send ${userWallet.currencyAcronim}"),
                  onPressed: () async {
                    screenCallback(PageEnum.SendCoins, AppBarEnum.Authorized,
                        userWallet.currencyAcronim);
                  },
                )
              ]),
        ))
      ],
    );
  }

  @override
  int get rowCount => userWallets.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  int _selectedCount = 0;

  void selectAll(bool? checked) {
    for (final userWallet in userWallets) {
      userWallet.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? userWallets.length : 0;
    notifyListeners();
  }
}
