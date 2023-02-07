import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecats/Extensions/hex_color.dart';
import 'package:ecats/account/loading_body_widget.dart';
import 'package:ecats/assets/constants.dart' as Constants;
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/requests/currency_response_request_model.dart';
import 'package:ecats/models/requests/user_wallet_response_request_model.dart';
import 'package:ecats/models/requests/user_wallets_response_request_model.dart';
import 'package:ecats/models/table_data_sources/wallets_by_user_data_source.dart';
import 'package:ecats/services/http_service.dart';
import 'package:flutter/material.dart';

import './shared/data_table/nav_helper.dart';

class WalletsBodyWidget extends StatefulWidget {
  final void Function(PageEnum, AppBarEnum, dynamic) screenCallback;

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
      ),
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
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    color: Colors.white,
                    child: Column(children: [
                      Expanded(
                        child: PaginatedDataTable2(
                          dataRowHeight: 100,
                          headingRowHeight: 40,
                          fixedLeftColumns: 5,
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
                              Container(
                                alignment: FractionalOffset.centerLeft,
                                child: Text(
                                  "Platform wallets (only for inner transactions):",
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: HexColor.fromHex('#5c6369')),
                                ),
                              ),
                              //if (getCurrentRouteOption(context) == custPager &&
                              // _controller != null)
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
                          autoRowsToHeight:
                              getCurrentRouteOption(context) == autoRows,
                          fit: FlexFit.tight,
                          border: const TableBorder(
                              top:
                                  BorderSide(width: 0, style: BorderStyle.none),
                              bottom:
                                  BorderSide(width: 0, style: BorderStyle.none),
                              left:
                                  BorderSide(width: 0, style: BorderStyle.none),
                              right:
                                  BorderSide(width: 0, style: BorderStyle.none),
                              verticalInside:
                                  BorderSide(width: 0, style: BorderStyle.none),
                              horizontalInside:
                                  BorderSide(color: Colors.grey, width: 0.2)),
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
                          //onSelectAll: _refferalsDataSource.selectAll,
                          //controller: getCurrentRouteOption(context) == custPager
                          //? _controller
                          //: null,
                          //hidePaginator: getCurrentRouteOption(context) == custPager,
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
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Divider(color: HexColor.fromHex('#6C757D')),
                      ),
                      Container(
                        alignment: FractionalOffset.centerLeft,
                        child: Text(
                          "Create income blockchain wallet(address)",
                          style: TextStyle(
                              fontFamily: 'Nunito',
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
                            var uri = Uri.parse(
                                "https://${Constants.SERVER_URL}/${Constants.ServerApiEndpoints.WALLET_CREATE}?selectCurrency=${selectedAcronim}");
                            var response =
                                await _httpService.postWithoutBody(uri);
                            var value = await response.stream.bytesToString();

                            if (response.statusCode == 200) {
                              widget.screenCallback(PageEnum.Success,
                                  AppBarEnum.Authorized, null);
                            } else {
                              widget.screenCallback(
                                  PageEnum.Error, AppBarEnum.Authorized, value);
                            }
                          },
                          child: const Text(
                            "Create",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    ]))));
  }
}
