import 'package:data_table_2/data_table_2.dart';
import 'package:ecats/assets/constants.dart';
import 'package:ecats/models/enums/order_status_enum.dart';
import 'package:ecats/models/requests/orders/closed_orders_by_user_request_model.dart';
import 'package:flutter/material.dart';

class ClosedOrdersByUserDataSource extends DataTableSource {
  ClosedOrdersByUserDataSource.empty(this.context) {
    closedOrders = [];
  }

  ClosedOrdersByUserDataSource(this.context, this.closedOrders,
      [this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]);

  final BuildContext context;
  late List<ClosedOrderByUserRequestModel> closedOrders;
  bool hasRowTaps = false;
  bool hasRowHeightOverrides = false;
  bool hasZebraStripes = false;

  void sort<T>(Comparable<T> Function(ClosedOrderByUserRequestModel d) getField,
      bool ascending) {
    closedOrders.sort((a, b) {
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
    if (index >= closedOrders.length) throw 'index > _closedOrders.length';
    final closedOrder = closedOrders[index];
    return DataRow2.byIndex(
      index: index,
      selected: closedOrder.selected,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      cells: [
        DataCell(Container(
          alignment: Alignment.centerLeft,
          child: Text(closedOrder.pairAcronim, textAlign: TextAlign.left),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(closedOrder.closedPrice.toString(),
              textAlign: TextAlign.left),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(closedOrder.amount.toString(), textAlign: TextAlign.left),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(closedOrder.total.toString(), textAlign: TextAlign.left),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(DateTimeFormat.format(closedOrder.createDate),
              textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(DateTimeFormat.format(closedOrder.closedDate),
              textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(
              OrderStatusEnum.values[closedOrder.status]
                  .toString()
                  .split('.')
                  .last,
              textAlign: TextAlign.center),
        ))
      ],
    );
  }

  @override
  int get rowCount => closedOrders.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  int _selectedCount = 0;

  void selectAll(bool? checked) {
    for (final closedOrder in closedOrders) {
      closedOrder.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? closedOrders.length : 0;
    notifyListeners();
  }
}
