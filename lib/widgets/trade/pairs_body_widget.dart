import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:ecats/assets/constants.dart' as Constants;
import 'package:ecats/assets/data_table/nav_helper.dart';
import 'package:ecats/models/requests/pair_response_request_model.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:ecats/models/table_data_sources/pairs_data_source.dart';
import 'package:ecats/services/http_service.dart';
import 'package:ecats/widgets/shared/loading_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PairsBodyWidget extends StatefulWidget {
  final void Function(PageModel?, bool, PageModel) screenCallback;

  const PairsBodyWidget({super.key, required this.screenCallback});

  @override
  State<PairsBodyWidget> createState() => _PairsBodyWidgetState();
}

class _PairsBodyWidgetState extends State<PairsBodyWidget> {
  final _httpService = HttpService();
  bool isLoading = true;
  late double columnHeight = 120 - (MediaQuery.of(context).size.width / 10);

  //final int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  //int? _sortColumnIndex;
  //bool _sortAscending = true;
  PaginatorController? _controller;
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late PairsDataSource _pairsDataSource;
  late List<PairResponseRequestModel> _model;

  @override
  void initState() {
    super.initState();

    _updateData();
  }

  @override
  void dispose() {
    _pairsDataSource.dispose();
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

    var uri =
        Uri.https(Constants.SERVER_URL, Constants.ServerApiEndpoints.PAIRS);
    var response = await _httpService.get(uri);
    var value = await response.stream.bytesToString();

    _model = List<PairResponseRequestModel>.from(jsonDecode(value)
        ?.map((model) => PairResponseRequestModel.fromJson(model)));
    _pairsDataSource = PairsDataSource(context, _model, widget.screenCallback);
    _refreshController.refreshCompleted();
    setState(() => isLoading = false);
  }

  void sort<T>(Comparable<T> Function(PairResponseRequestModel d) getField,
      int columnIndex, bool ascending) {
    _pairsDataSource.sort<T>(getField, ascending);
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
          child: const Text('Name'),
        ),
      ),
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
          child: const Text('Change 15m'),
        ),
      ),
      DataColumn2(
        size: ColumnSize.S,
        numeric: true,
        label: Container(
          alignment: Alignment.center,
          child: const Text('Change 1h'),
        ),
      ),
      DataColumn2(
        size: ColumnSize.S,
        label: Container(
          alignment: Alignment.center,
          child: const Text('Change 24h'),
        ),
      ),
      DataColumn2(
        size: ColumnSize.L,
        label: Container(
          alignment: Alignment.centerRight,
          child: const Text('Volume 24h'),
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
                        minWidth: 400,
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
                            const Text('Pairs'),
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
                        autoRowsToHeight:
                            getCurrentRouteOption(context) == autoRows,
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
                            ? PairsDataSource.empty(context)
                            : _pairsDataSource,
                      )),
                ])));
  }
}
