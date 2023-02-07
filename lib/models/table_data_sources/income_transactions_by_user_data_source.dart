import 'package:data_table_2/data_table_2.dart';
import 'package:ecats/assets/constants.dart';
import 'package:ecats/models/requests/income_transaction_request_model.dart';
import 'package:ecats/models/requests/my_income_transaction_request_model.dart';
import 'package:flutter/material.dart';

class IncomeTransactionsByUserDataSouce extends DataTableSource {
  IncomeTransactionsByUserDataSouce.empty(this.context) {
    incomeTransactions.incomeTransactions = [];
  }

  IncomeTransactionsByUserDataSouce(this.context, this.incomeTransactions,
      [this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]);

  final BuildContext context;
  late MyIncomeTransactionRequestModel incomeTransactions;
  bool hasRowTaps = false;
  bool hasRowHeightOverrides = false;
  bool hasZebraStripes = false;

  void sort<T>(
      Comparable<T> Function(EventRequestModel d) getField, bool ascending) {
    incomeTransactions.incomeTransactions?.sort((a, b) {
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
    if (index >= incomeTransactions.incomeTransactions!.length)
      throw 'index > _incomeTransactions.length';
    final incomeTransaction = incomeTransactions.incomeTransactions?[index];
    return DataRow2.byIndex(
      index: index,
      selected: incomeTransaction!.selected,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      cells: [
        DataCell(Container(
          alignment: Alignment.centerLeft,
          child: Text(incomeTransaction.currencyAcronim,
              textAlign: TextAlign.left),
        )),
        DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(incomeTransaction.amount.toString(),
              textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(incomeTransaction.transactionFee.toString(),
              textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.centerRight,
          child:
              Text(incomeTransaction.fromAdress, textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(incomeTransaction.toAddress, textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(DateTimeFormat.format(incomeTransaction.createdDate),
              textAlign: TextAlign.center),
        ))
      ],
    );
  }

  @override
  int get rowCount => incomeTransactions.incomeTransactions!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  int _selectedCount = 0;

  void selectAll(bool? checked) {
    for (final incomeTransaction in incomeTransactions.incomeTransactions!) {
      incomeTransaction.selected = checked ?? false;
    }
    _selectedCount =
        (checked ?? false) ? incomeTransactions.incomeTransactions!.length : 0;
    notifyListeners();
  }
}
