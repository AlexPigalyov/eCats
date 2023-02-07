import 'package:data_table_2/data_table_2.dart';
import 'package:ecats/assets/constants.dart';
import 'package:ecats/models/enums/event_type_enum.dart';
import 'package:ecats/models/requests/event_request_model.dart';
import 'package:flutter/material.dart';

class EventsByUserDataSource extends DataTableSource {
  EventsByUserDataSource.empty(this.context) {
    events = [];
  }

  EventsByUserDataSource(this.context, this.events,
      [this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]);

  final BuildContext context;
  late List<EventRequestModel> events;
  bool hasRowTaps = false;
  bool hasRowHeightOverrides = false;
  bool hasZebraStripes = false;

  void sort<T>(
      Comparable<T> Function(EventRequestModel d) getField, bool ascending) {
    events.sort((a, b) {
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
    if (index >= events.length) throw 'index > _events.length';
    final event = events[index];
    return DataRow2.byIndex(
      index: index,
      selected: event.selected,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      cells: [
        DataCell(Container(
          alignment: Alignment.centerLeft,
          child: Text(
              EventTypeEnum.values[event.type].toString().split('.').last,
              textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(event.comment, textAlign: TextAlign.center),
        )),
        DataCell(Container(
          alignment: Alignment.center,
          child: Text(DateTimeFormat.format(event.whenDate),
              textAlign: TextAlign.center),
        )),
      ],
    );
  }

  @override
  int get rowCount => events.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  int _selectedCount = 0;

  void selectAll(bool? checked) {
    for (final event in events) {
      event.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? events.length : 0;
    notifyListeners();
  }
}
