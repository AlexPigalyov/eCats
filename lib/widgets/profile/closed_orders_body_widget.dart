import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:ecats/assets/constants.dart' as Constants;
import 'package:ecats/assets/data_table/nav_helper.dart';
import 'package:ecats/models/requests/orders/closed_orders_by_user_request_model.dart';
import 'package:ecats/models/table_data_sources/closed_orders_by_user_data_source.dart';
import 'package:ecats/services/http_service.dart';
import 'package:ecats/widgets/shared/loading_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClosedOrdersBodyWidget extends StatefulWidget {
  const ClosedOrdersBodyWidget({super.key});

  @override
  State<ClosedOrdersBodyWidget> createState() => _ClosedOrdersBodyWidgetState();
}

class _ClosedOrdersBodyWidgetState extends State<ClosedOrdersBodyWidget> {
  final _httpService = HttpService();
  late double columnHeight = 120 - (MediaQuery.of(context).size.width / 10);
  bool isLoading = true;

  //int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  //int? _sortColumnIndex;
  //bool _sortAscending = true;
  PaginatorController? _controller;

  late ClosedOrdersByUserDataSource _closedOrdersDataSource;
  late List<ClosedOrderByUserRequestModel> _model;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _updateData();
  }

  @override
  void dispose() {
    _closedOrdersDataSource.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller = PaginatorController();

    //if (getCurrentRouteOption(context) == defaultSorting) {
    // _sortColumnIndex = 1;
    //}
  }

  Future _updateData() async {
    setState(() => isLoading = true);

    var uri = Uri.https(
        Constants.SERVER_URL, Constants.ServerApiEndpoints.USER_CLOSED_ORDERS);
    var response = await _httpService.get(uri);
    var value = await response.stream.bytesToString();

    _model = List<ClosedOrderByUserRequestModel>.from(jsonDecode(value)
        ?.map((model) => ClosedOrderByUserRequestModel.fromJson(model)));
    _closedOrdersDataSource = ClosedOrdersByUserDataSource(context, _model);
    _refreshController.refreshCompleted();
    setState(() => isLoading = false);
  }

  void sort<T>(Comparable<T> Function(ClosedOrderByUserRequestModel d) getField,
      int columnIndex, bool ascending) {
    _closedOrdersDataSource.sort<T>(getField, ascending);
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
            child: const Text('Pair'),
          ),
          fixedWidth: 40),
      DataColumn2(
        size: ColumnSize.S,
        numeric: true,
        label: Container(
          alignment: Alignment.center,
          child: const Text('Price'),
        ),
      ),
      DataColumn2(
        size: ColumnSize.S,
        numeric: true,
        label: Container(
          alignment: Alignment.center,
          child: const Text('Amount'),
        ),
      ),
      DataColumn2(
        size: ColumnSize.S,
        numeric: true,
        label: Container(
          alignment: Alignment.center,
          child: const Text('Total'),
        ),
      ),
      DataColumn2(
        size: ColumnSize.L,
        label: Container(
          alignment: Alignment.center,
          child: const Text('Created'),
        ),
      ),
      DataColumn2(
        size: ColumnSize.L,
        label: Container(
          alignment: Alignment.center,
          child: const Text('Closed'),
        ),
      ),
      DataColumn2(
        size: ColumnSize.S,
        label: Container(
          alignment: Alignment.center,
          child: const Text('Status'),
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
            child: SmartRefresher(
                onRefresh: () => _updateData(),
                controller: _refreshController,
                enablePullUp: true,
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  Theme(
                      data: ThemeData(
                          scrollbarTheme: ScrollbarThemeData(
                              thumbVisibility: MaterialStateProperty.all(true),
                              thumbColor: MaterialStateProperty.all<Color>(
                                  Colors.black))),
                      child: PaginatedDataTable2(
                        scrollController: _scrollController,
                        minWidth: 600,
                        headingRowHeight: 40,
                        showCheckboxColumn: false,
                        horizontalMargin: 20,
                        checkboxHorizontalMargin: 12,
                        columnSpacing: 0,
                        wrapInCard: false,
                        renderEmptyRowsInTheEnd: false,
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.grey[200]!),
                        header: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Closed Orders'),
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
                        autoRowsToHeight: true,
                        fit: FlexFit.tight,
                        border: const TableBorder(
                            top: BorderSide(width: 0, style: BorderStyle.none),
                            bottom:
                                BorderSide(width: 0, style: BorderStyle.none),
                            left: BorderSide(width: 0, style: BorderStyle.none),
                            right:
                                BorderSide(width: 0, style: BorderStyle.none),
                            verticalInside:
                                BorderSide(width: 0, style: BorderStyle.none),
                            horizontalInside:
                                BorderSide(color: Colors.grey, width: 0.2)),
                        initialFirstRowIndex: 0,
                        hidePaginator: true,
                        columns: _columns,
                        empty: Center(
                            child: Container(
                                padding: const EdgeInsets.all(20),
                                color: Colors.grey[200],
                                child: const Text('No data'))),
                        source: getCurrentRouteOption(context) == noData
                            ? ClosedOrdersByUserDataSource.empty(context)
                            : _closedOrdersDataSource,
                      ))
                ])));
  }
}
