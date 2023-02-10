import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:ecats/assets/constants.dart' as Constants;
import 'package:ecats/assets/data_table/nav_helper.dart';
import 'package:ecats/models/requests/wallets/user_wallet_response_request_model.dart';
import 'package:ecats/models/requests/wallets/user_wallets_response_request_model.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:ecats/models/table_data_sources/wallets_by_user_data_source.dart';
import 'package:ecats/services/http_service.dart';
import 'package:ecats/widgets/shared/loading_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WalletsBodyWidget extends StatefulWidget {
  final void Function(PageModel?, bool, PageModel) screenCallback;

  const WalletsBodyWidget({super.key, required this.screenCallback});

  @override
  State<WalletsBodyWidget> createState() => _WalletsBodyWidgetState();
}

class _WalletsBodyWidgetState extends State<WalletsBodyWidget> {
  final _httpService = HttpService();
  bool isLoading = true;

  //final int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  //int? _sortColumnIndex;
  //bool _sortAscending = true;
  PaginatorController? _controller;

  late WalletsByUserDataSource _userWallets;
  late UserWalletsResponseRequestModel _model;
  late String selectedAcronim;
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    _updateData();
  }

  @override
  void dispose() {
    _userWallets.dispose();
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
        Uri.https(Constants.SERVER_URL, Constants.ServerApiEndpoints.WALLETS);
    var response = await _httpService.get(uri);
    var value = await response.stream.bytesToString();

    _model = UserWalletsResponseRequestModel.fromJson(jsonDecode(value));
    _userWallets = WalletsByUserDataSource(context,
        _model.userWallets ?? _model.emptyUserWallets(), widget.screenCallback);

    selectedAcronim = (_model.currencies ?? []).first.acronim;
    _refreshController.refreshCompleted();
    setState(() => isLoading = false);
  }

  void sortUserWallets<T>(
      Comparable<T> Function(UserWalletResponseRequestModel d)
          getUserWalletsField,
      int columnIndex,
      bool ascending) {
    _userWallets.sort<T>(getUserWalletsField, ascending);
    setState(() {
      //_sortColumnIndex = columnIndex;
      //_sortAscending = ascending;
    });
  }

  List<DataColumn> get _columnsUserWallets {
    return [
      DataColumn2(
          size: ColumnSize.S,
          label: Container(
            alignment: Alignment.centerLeft,
            child: const Text('Currency'),
          ),
          fixedWidth: 60),
      DataColumn2(
        size: ColumnSize.S,
        numeric: true,
        label: Container(
          alignment: Alignment.center,
          child: const Text('Balance'),
        ),
      ),
      DataColumn2(
        size: ColumnSize.S,
        label: Container(
          alignment: Alignment.center,
          child: const Text('Address'),
        ),
      ),
      DataColumn2(
        size: ColumnSize.L,
        label: Container(
          alignment: Alignment.center,
          child: const Text('Action'),
        ),
      ),
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
                        dataRowHeight: 100,
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
                            const Flexible(child: Text('Platform wallets:')),
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
                        columns: _columnsUserWallets,
                        empty: Center(
                            child: Container(
                                padding: const EdgeInsets.all(20),
                                color: Colors.grey[200],
                                child: const Text('No data'))),
                        source: getCurrentRouteOption(context) == noData
                            ? WalletsByUserDataSource.empty(context)
                            : _userWallets,
                      )),
                ])));
  }
}
