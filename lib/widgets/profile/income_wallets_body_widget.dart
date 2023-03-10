import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecats/Extensions/hex_color.dart';
import 'package:ecats/assets/constants.dart' as Constants;
import 'package:ecats/assets/data_table/nav_helper.dart';
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/requests/currency_response_request_model.dart';
import 'package:ecats/models/requests/wallets/income_wallet_response_request_model.dart';
import 'package:ecats/models/requests/wallets/user_wallets_response_request_model.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:ecats/models/table_data_sources/income_wallets_by_user_data_source.dart';
import 'package:ecats/services/http_service.dart';
import 'package:ecats/widgets/shared/loading_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IncomeWalletsBodyWidget extends StatefulWidget {
  final void Function(PageModel?, bool, PageModel) screenCallback;

  const IncomeWalletsBodyWidget({super.key, required this.screenCallback});

  @override
  State<IncomeWalletsBodyWidget> createState() =>
      _IncomeWalletsBodyWidgetState();
}

class _IncomeWalletsBodyWidgetState extends State<IncomeWalletsBodyWidget> {
  final _httpService = HttpService();
  bool isLoading = true;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //final int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  //int? _sortColumnIndex;
  //bool _sortAscending = true;
  PaginatorController? _controller;
  final ScrollController _scrollController = ScrollController();
  late IncomeWalletsByUserDataSource _incomeUserWallets;
  late UserWalletsResponseRequestModel _model;
  late String selectedAcronim;
  late double columnHeight = 100 - (MediaQuery.of(context).size.width / 10);

  @override
  void initState() {
    super.initState();

    _updateData();
  }

  @override
  void dispose() {
    _incomeUserWallets.dispose();
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
    _incomeUserWallets = IncomeWalletsByUserDataSource(
        context, _model.userIncomeWallets ?? _model.emptyIncomeUserWallets());

    selectedAcronim = (_model.currencies ?? []).first.acronim;

    _refreshController.refreshCompleted();
    setState(() => isLoading = false);
  }

  void sortIncomeUserWallets<T>(
      Comparable<T> Function(IncomeWalletResponseRequestModel d)
          getIncomeUserWalletsField,
      int columnIndex,
      bool ascending) {
    _incomeUserWallets.sort<T>(getIncomeUserWalletsField, ascending);
    setState(() {
      //_sortColumnIndex = columnIndex;
      //_sortAscending = ascending;
    });
  }

  List<DataColumn> get _columnsIncomeUserWallets {
    return [
      DataColumn2(
        size: ColumnSize.S,
        label: Container(
          alignment: Alignment.centerLeft,
          child: const Text('Currency'),
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
          child: const Text('Created'),
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
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        color: Colors.white,
                        child: Column(children: [
                          Expanded(
                              child: Theme(
                            data: ThemeData(
                                scrollbarTheme: ScrollbarThemeData(
                                    thumbVisibility:
                                        MaterialStateProperty.all(true),
                                    thumbColor:
                                        MaterialStateProperty.all<Color>(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Income wallets",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: HexColor.fromHex('#5c6369')),
                                    ),
                                  ),
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
                                  top: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                  bottom: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                  left: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                  right: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                  verticalInside: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                  horizontalInside: BorderSide(
                                      color: Colors.grey, width: 0.2)),
                              initialFirstRowIndex: 0,
                              hidePaginator: true,
                              columns: _columnsIncomeUserWallets,
                              empty: Center(
                                  child: Container(
                                      padding: const EdgeInsets.all(20),
                                      color: Colors.grey[200],
                                      child: const Text('No data'))),
                              source: getCurrentRouteOption(context) == noData
                                  ? IncomeWalletsByUserDataSource.empty(context)
                                  : _incomeUserWallets,
                            ),
                          )),
                          Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Divider(color: HexColor.fromHex('#6C757D')),
                          ),
                          Container(
                            alignment: FractionalOffset.centerLeft,
                            child: Text(
                              "Create income blockchain wallet(address)",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: HexColor.fromHex('#5c6369')),
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2<String>(
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  )),
                              value: selectedAcronim,
                              onChanged: (String? newValue) {
                                selectedAcronim = newValue!;
                              },
                              isExpanded: true,
                              itemHeight: 48,
                              focusColor: Colors.white,
                              items: (_model.currencies ?? [])
                                  .map((CurrencyResponseRequestModel value) {
                                return DropdownMenuItem<String>(
                                  value: value.acronim,
                                  child: Text(value.acronim),
                                );
                              }).toList(),
                              // add extra sugar..
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 42,
                              //underline: const SizedBox(),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            alignment: FractionalOffset.centerLeft,
                            child: MaterialButton(
                              color: HexColor.fromHex('#1b6ec2'),
                              height: 50,
                              onPressed: () async {
                                setState(() => isLoading = true);

                                var uri = Uri.parse(
                                    "https://${Constants.SERVER_URL}/${Constants.ServerApiEndpoints.WALLET_CREATE}?selectCurrency=${selectedAcronim}");
                                var response =
                                    await _httpService.postWithoutBody(uri);
                                var value =
                                    await response.stream.bytesToString();

                                if (response.statusCode == 200) {
                                  widget.screenCallback(
                                      PageModel(
                                          page: PageEnum.IncomeWallets,
                                          appBar: AppBarEnum.Authorized,
                                          args: null),
                                      true,
                                      PageModel(
                                          page: PageEnum.Success,
                                          appBar: AppBarEnum.Authorized,
                                          args: null));
                                } else {
                                  widget.screenCallback(
                                      PageModel(
                                          page: PageEnum.IncomeWallets,
                                          appBar: AppBarEnum.Authorized,
                                          args: null),
                                      true,
                                      PageModel(
                                          page: PageEnum.Error,
                                          appBar: AppBarEnum.Authorized,
                                          args: value));
                                }

                                setState(() => isLoading = false);
                              },
                              child: const Text(
                                "Create",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          )
                        ])))));
  }
}
