import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:ecats/assets/constants.dart' as Constants;
import 'package:ecats/assets/data_table/custom_pager.dart';
import 'package:ecats/assets/data_table/nav_helper.dart';
import 'package:ecats/models/requests/event_request_model.dart';
import 'package:ecats/models/table_data_sources/events_by_user_data_source.dart';
import 'package:ecats/services/http_service.dart';
import 'package:ecats/widgets/shared/loading_body_widget.dart';
import 'package:flutter/material.dart';

class EventsBodyWidget extends StatefulWidget {
  const EventsBodyWidget({super.key});

  @override
  State<EventsBodyWidget> createState() => _EventsBodyWidgetState();
}

class _EventsBodyWidgetState extends State<EventsBodyWidget> {
  final _httpService = HttpService();
  bool isLoading = true;
  late double columnHeight =  100 - (MediaQuery.of(context).size.width / 10);
  //final int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  //int? _sortColumnIndex;
  //bool _sortAscending = true;
  PaginatorController? _controller;

  late EventsByUserDataSource _eventsDataSource;
  late List<EventRequestModel> _model;

  @override
  void initState() {
    super.initState();

    _updateData();
  }

  @override
  void dispose() {
    _eventsDataSource.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller = PaginatorController();
    /*
    if (getCurrentRouteOption(context) == defaultSorting) {
      _sortColumnIndex = 1;
    }*/
  }

  Future _updateData() async {
    setState(() => isLoading = true);

    var uri = Uri.https(
        Constants.SERVER_URL, Constants.ServerApiEndpoints.USER_EVENTS);
    var response = await _httpService.get(uri);
    var value = await response.stream.bytesToString();

    _model = List<EventRequestModel>.from(
        jsonDecode(value)?.map((model) => EventRequestModel.fromJson(model)));
    _eventsDataSource = EventsByUserDataSource(context, _model);

    setState(() => isLoading = false);
  }

  void sort<T>(Comparable<T> Function(EventRequestModel d) getField,
      int columnIndex, bool ascending) {
    _eventsDataSource.sort<T>(getField, ascending);
    setState(() {
      //_sortColumnIndex = columnIndex;
      //_sortAscending = ascending;
    });
  }

  List<DataColumn> get _columns {
    return [
      DataColumn2(
        size: ColumnSize.S,
        label: Container(
          alignment: Alignment.centerLeft,
          child: const Text('Event'),
        ),
      ),
      DataColumn2(
        size: ColumnSize.S,
        label: Container(
          alignment: Alignment.center,
          child: const Text('Comment'),
        ),
      ),
      DataColumn2(
        size: ColumnSize.L,
        label: Container(
          alignment: Alignment.center,
          child: const Text('Date'),
        ),
      )
    ];
  }

  String getCurrentRouteOption(BuildContext context) {
    var isEmpty = ModalRoute.of(context) != null &&
            ModalRoute.of(context)!.settings.arguments != null &&
            ModalRoute.of(context)!.settings.arguments is String
        ? ModalRoute.of(context)!.settings.arguments as String
        : '';

    return isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingBodyWidget()
        : Center(
            child: Stack(alignment: Alignment.bottomCenter, children: [
            PaginatedDataTable2(
              dataRowHeight: columnHeight < 35 ? 35 : columnHeight,
              headingRowHeight: 40,
              fixedLeftColumns: 5,
              showCheckboxColumn: false,
              horizontalMargin: 20,
              checkboxHorizontalMargin: 12,
              columnSpacing: 0,
              wrapInCard: false,
              renderEmptyRowsInTheEnd: false,
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
              header: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Events'),
                  //if (getCurrentRouteOption(context) == custPager &&
                  //_controller != null)
                  //PageNumber(controller: _controller!),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () async {
                          await _updateData();
                        },
                      ),
                    ),
                  )
                ],
              ),
              //rowsPerPage: _rowsPerPage,
              autoRowsToHeight: getCurrentRouteOption(context) == autoRows,
              fit: FlexFit.tight,
              border: const TableBorder(
                  top: BorderSide(width: 0, style: BorderStyle.none),
                  bottom: BorderSide(width: 0, style: BorderStyle.none),
                  left: BorderSide(width: 0, style: BorderStyle.none),
                  right: BorderSide(width: 0, style: BorderStyle.none),
                  verticalInside: BorderSide(width: 0, style: BorderStyle.none),
                  horizontalInside: BorderSide(color: Colors.grey, width: 0.2)),
              //onRowsPerPageChanged: (value) {
              // _rowsPerPage = value!;
              //},
              initialFirstRowIndex: 0,
              //onPageChanged: (rowIndex) {
              //TODO: pagination
              //},
              //sortColumnIndex: _sortColumnIndex,
              //sortAscending: _sortAscending,
              //sortArrowIcon: Icons.keyboard_arrow_up,
              // custom arrow
              //sortArrowAnimationDuration: const Duration(milliseconds: 0),
              // custom animation duration
              //onSelectAll: _openOrdersDataSource.selectAll,
              //controller: getCurrentRouteOption(context) == custPager
              //? _controller
              //: null,
              //hidePaginator: getCurrentRouteOption(context) == custPager,
              hidePaginator: true,
              columns: _columns,
              empty: Center(
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.grey[200],
                      child: const Text('No data'))),
              source: getCurrentRouteOption(context) == noData
                  ? EventsByUserDataSource.empty(context)
                  : _eventsDataSource,
            ),
            if (getCurrentRouteOption(context) == custPager)
              Positioned(bottom: 16, child: CustomPager(_controller!))
          ]));
  }
}
