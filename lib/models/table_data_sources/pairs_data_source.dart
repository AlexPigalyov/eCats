import 'package:data_table_2/data_table_2.dart';
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/requests/pair_response_request_model.dart';
import 'package:flutter/material.dart';

class PairsDataSource extends DataTableSource {
  PairsDataSource.empty(this.context) {
    pairs = [];
  }

  PairsDataSource(this.context, this.pairs, this.screenCallback,
      [this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]);

  late void Function(PageEnum, AppBarEnum, dynamic) screenCallback;
  final BuildContext context;
  late List<PairResponseRequestModel> pairs;
  bool hasRowTaps = false;
  bool hasRowHeightOverrides = false;
  bool hasZebraStripes = false;

  void sort<T>(Comparable<T> Function(PairResponseRequestModel d) getField,
      bool ascending) {
    pairs.sort((a, b) {
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
    if (index >= pairs.length) throw 'index > _pairs.length';
    final pair = pairs[index];
    return DataRow2.byIndex(
      index: index,
      selected: pair.selected,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      cells: [
        DataCell(Container(
          alignment: Alignment.centerLeft,
          child: TextButton(
            child: Text(pair.header),
            onPressed: () async {
              screenCallback(
                  PageEnum.CryptoTrade, AppBarEnum.Authorized, pair.acronim);
            },
          ),
        )),
        DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text("${pair.price} ${pair.currency2Postfix}",
              textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text("${pair.change15m} %",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: (pair.change15m == 0
                      ? Colors.grey
                      : (pair.change15m < 0 ? Colors.red : Colors.green)))),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text("${pair.change1h} %",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: (pair.change1h == 0
                      ? Colors.grey
                      : (pair.change1h < 0 ? Colors.red : Colors.green)))),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text("${pair.change24h} %",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: (pair.change24h == 0
                      ? Colors.grey
                      : (pair.change24h < 0 ? Colors.red : Colors.green)))),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text("${pair.volume24h} ${pair.currency2Postfix}",
              textAlign: TextAlign.center),
        )),
      ],
    );
  }

  @override
  int get rowCount => pairs.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  int _selectedCount = 0;

  void selectAll(bool? checked) {
    for (final pair in pairs) {
      pair.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? pairs.length : 0;
    notifyListeners();
  }
}
