import 'package:data_table_2/data_table_2.dart';
import 'package:ecats/assets/constants.dart';
import 'package:ecats/models/requests/user_reffs/user_referals_request_model.dart';
import 'package:ecats/models/requests/user_reffs/user_refferal_request_model.dart';
import 'package:flutter/material.dart';

class UserReferalsByUserDataSource extends DataTableSource {
  UserReferalsByUserDataSource.empty(this.context) {
    referals.myRefferals = [];
  }

  UserReferalsByUserDataSource(this.context, this.referals,
      [this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]);

  final BuildContext context;
  late UserRefferalRequestModel referals;
  bool hasRowTaps = false;
  bool hasRowHeightOverrides = false;
  bool hasZebraStripes = false;

  void sort<T>(Comparable<T> Function(UserReferalsRequestModel d) getField,
      bool ascending) {
    referals.myRefferals?.sort((a, b) {
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
    if (index >= referals.myRefferals!.length)
      throw 'index > _userReferals.length';
    final referal = referals.myRefferals![index];
    return DataRow2.byIndex(
      index: index,
      selected: referal.selected,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      cells: [
        DataCell(Container(
          alignment: Alignment.centerLeft,
          child: Text(referal.email, textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(DateTimeFormat.format(referal.registrationDate),
              textAlign: TextAlign.center),
        ))
      ],
    );
  }

  @override
  int get rowCount => referals.myRefferals!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  int _selectedCount = 0;

  void selectAll(bool? checked) {
    for (final refferal in referals.myRefferals!) {
      refferal.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? referals.myRefferals!.length : 0;
    notifyListeners();
  }
}
