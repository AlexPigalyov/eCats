import 'package:data_table_2/data_table_2.dart';
import 'package:ecats/assets/constants.dart';
import 'package:ecats/models/requests/income_wallet_response_request_model.dart';
import 'package:flutter/material.dart';

class IncomeWalletsByUserDataSource extends DataTableSource {
  IncomeWalletsByUserDataSource.empty(this.context) {
    incomeUserWallets = [];
  }

  IncomeWalletsByUserDataSource(this.context, this.incomeUserWallets,
      [this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]);

  final BuildContext context;
  late List<IncomeWalletResponseRequestModel> incomeUserWallets;
  bool hasRowTaps = false;
  bool hasRowHeightOverrides = false;
  bool hasZebraStripes = false;

  void sort<T>(
      Comparable<T> Function(IncomeWalletResponseRequestModel d) getField,
      bool ascending) {
    incomeUserWallets.sort((a, b) {
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
    if (index >= incomeUserWallets.length)
      throw 'index > _userIncomeWallets.length';
    final userWallet = incomeUserWallets[index];
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
          child: Text(userWallet.address, textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(DateTimeFormat.format(userWallet.created),
              textAlign: TextAlign.center),
        ))
      ],
    );
  }

  @override
  int get rowCount => incomeUserWallets.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  int _selectedCount = 0;

  void selectAll(bool? checked) {
    for (final incomeUserWallet in incomeUserWallets) {
      incomeUserWallet.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? incomeUserWallets.length : 0;
    notifyListeners();
  }
}
