import 'package:data_table_2/data_table_2.dart';
import 'package:ecats/assets/constants.dart' as Constants;
import 'package:ecats/assets/constants.dart';
import 'package:ecats/models/requests/orders/open_orders_by_user_request_model.dart';
import 'package:ecats/services/http_service.dart';
import 'package:flutter/material.dart';

class OpenOrdersByUserDataSource extends DataTableSource {
  OpenOrdersByUserDataSource.empty(this.context) {
    openOrders = [];
  }

  OpenOrdersByUserDataSource(this.context, this.openOrders, this.updateCallback,
      [this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]);

  late Function updateCallback;
  final HttpService _httpService = HttpService();
  final BuildContext context;
  late List<OpenOrderByUserRequestModel> openOrders;
  bool hasRowTaps = false;
  bool hasRowHeightOverrides = false;
  bool hasZebraStripes = false;

  void sort<T>(Comparable<T> Function(OpenOrderByUserRequestModel d) getField,
      bool ascending) {
    openOrders.sort((a, b) {
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
    if (index >= openOrders.length) throw 'index > _openOrders.length';
    final openOrder = openOrders[index];
    return DataRow2.byIndex(
      index: index,
      selected: openOrder.selected,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      cells: [
        DataCell(Container(
          alignment: Alignment.centerLeft,
          child: Text(openOrder.pair, textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(openOrder.price.toString(), textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.centerRight,
          child: Text(openOrder.amount.toString(), textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(openOrder.total.toString(), textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(DateTimeFormat.format(openOrder.createDate),
              textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: TextButton(
            child: const Text("Cancel order"),
            onPressed: () async {
              var uri = Uri.parse(
                  "https://${Constants.SERVER_URL}/${Constants.ServerApiEndpoints.USER_CANCEL_ORDER}?id=${openOrder.id}&acronim=${openOrder.pair.replaceAll(' ', '')}");

              var res = await _httpService.get(uri);

              await updateCallback();
            },
          ),
        ))
      ],
    );
  }

  @override
  int get rowCount => openOrders.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  int _selectedCount = 0;

  void selectAll(bool? checked) {
    for (final openOrder in openOrders) {
      openOrder.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? openOrders.length : 0;
    notifyListeners();
  }
}
