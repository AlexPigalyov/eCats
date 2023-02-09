import 'dart:convert';

import 'package:ecats/assets/constants.dart' as Constants;
import 'package:ecats/assets/constants.dart';
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/requests/crypto_trade_response_request_model.dart';
import 'package:ecats/models/requests/orders/closed_order_response_request_model.dart';
import 'package:ecats/models/requests/orders/crypto_create_order.dart';
import 'package:ecats/models/requests/orders/order_by_desc_price_orderbook_response_request_model.dart';
import 'package:ecats/models/requests/pair_response_request_model.dart';
import 'package:ecats/services/http_service.dart';
import 'package:ecats/widgets/shared/loading_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:group_button/group_button.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:signalr_client/hub_connection.dart';
import 'package:signalr_client/hub_connection_builder.dart';

class CryptoTradeBodyWidget extends StatefulWidget {
  final void Function(PageEnum, AppBarEnum, dynamic) screenCallback;
  late String acronim;

  CryptoTradeBodyWidget({super.key, required this.screenCallback});

  @override
  State<CryptoTradeBodyWidget> createState() => _CryptoTradeBodyWidgetState();
}

class _CryptoTradeBodyWidgetState extends State<CryptoTradeBodyWidget> {
  final _httpService = HttpService();
  int groupValue_3 = 1;
  Color activeTabColor = Colors.green;
  bool isLoading = true;
  late CryptoTradeResponseRequestModel _model;
  late HubConnection hubConnection;
  late double change24H;
  double price = 0;
  double amount = 0;

  @override
  void initState() {
    hubConnection = HubConnectionBuilder()
        .withUrl(Uri.parse(
                "https://${Constants.SERVER_URL}/${widget.acronim.toLowerCase()}hub")
            .toString())
        .build();

    super.initState();

    _updateData();
  }

  @override
  void dispose() {
    hubConnection.stop();
    super.dispose();
  }

  Future _updateData() async {
    setState(() => isLoading = true);
    var uri = Uri.parse(
        "https://${Constants.SERVER_URL}/${Constants.ServerApiEndpoints.CRYPTO_TRADE}?acronim=${widget.acronim}");
    var response = await _httpService.get(uri);
    var value = await response.stream.bytesToString();

    _model = CryptoTradeResponseRequestModel.fromJson(jsonDecode(value));

    uri = Uri.https(Constants.SERVER_URL, Constants.ServerApiEndpoints.PAIRS);
    response = await _httpService.get(uri);
    value = await response.stream.bytesToString();

    var pairs = List<PairResponseRequestModel>.from(jsonDecode(value)
        ?.map((model) => PairResponseRequestModel.fromJson(model)));

    change24H = pairs
        .firstWhere((element) => element.acronim == widget.acronim)
        .change24h;

    hubConnection.on('ReceiveMessage', (List<Object> model) {
      var json = jsonDecode(model[0].toString());

      setState(() {
        _model.marketTrades = (json['MarketTrades'] as List<dynamic>)
            .map((marketTrade) =>
                ClosedOrderResponseRequestModel.fromJson(marketTrade))
            .toList();
        _model.buyOrderBook = (json['OrderBookBuy'] as List<dynamic>)
            .map((orderBookBuy) =>
                OrderByDescPriceOrderBookResponseRequest.fromJson(orderBookBuy))
            .toList();
        _model.sellOrderBook = (json['OrderBookSell'] as List<dynamic>)
            .map((orderBookSell) =>
                OrderByDescPriceOrderBookResponseRequest.fromJson(
                    orderBookSell))
            .toList();
      });
    });

    while (true) {
      try {
        if (hubConnection.state == HubConnectionState.Disconnected) {
          await hubConnection.start();
        }
        break;
      } on NoSuchMethodError catch (_) {}
    }

    setState(() => isLoading = false);
  }

  List<DataRow> _generateOrderBooks(
      List<OrderByDescPriceOrderBookResponseRequest> orderbook, bool isBuy) {
    if (isBuy) orderbook = orderbook.reversed.toList();

    var dataRows = orderbook.reversed
        .take(5)
        .map((e) => DataRow(cells: [
              DataCell(Text(e.price.toString(),
                  style: TextStyle(
                      color: isBuy ? Colors.green : Colors.red,
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold))),
              DataCell(Text(e.amount.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold))),
            ]))
        .toList();

    if (orderbook.length < 5) {
      var emptyFillers = List.filled(5 - orderbook.length, 0)
          .map((e) => DataRow(cells: [
                DataCell(Text('',
                    style: TextStyle(
                        color: isBuy ? Colors.green : Colors.red,
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        fontWeight: FontWeight.bold))),
                const DataCell(Text('',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        fontWeight: FontWeight.bold))),
              ]))
          .toList();

      if (isBuy) {
        dataRows.addAll(emptyFillers);
      } else {
        for (var filler in emptyFillers) {
          dataRows.insert(0, filler);
        }
      }
    }

    return dataRows;
  }

  List<DataRow> _generateUserOpenOrders() {
    return _model.userOpenOrders
            ?.map((e) => DataRow(cells: [
                  DataCell(Column(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5, top: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "${_model.firstCurrency}/${_model.secondCurrency}",
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text("Amount",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500))),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text("Price",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500))),
                      ],
                    )
                  ])),
                  DataCell(
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 5, top: 5),
                          alignment: Alignment.centerLeft,
                          child: const Text("",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: [
                            Text(e.amount.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                        Row(
                          children: [
                            Text(e.price.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                          ],
                        )
                      ],
                    ),
                  ),
                  DataCell(
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 5, top: 5),
                          alignment: Alignment.centerRight,
                          child: Text(DateTimeFormat.format(e.createDate),
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        ),
                        const Text(""),
                        Container(
                          alignment: Alignment.centerRight,
                          child: MaterialButton(
                            color: Colors.grey[300],
                            height: 30,
                            onPressed: () async {
                              var uri = Uri.parse(
                                  "https://${Constants.SERVER_URL}/${Constants.ServerApiEndpoints.USER_CANCEL_ORDER}?id=${e.id}&acronim=${_model.firstCurrency + _model.secondCurrency}");

                              var res = await _httpService.get(uri);

                              await _updateData();
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                fontSize: 12.6,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingBodyWidget()
        : Center(
            child: MultiSplitView(
                axis: Axis.vertical,
                controller: MultiSplitViewController(areas: [
                  Area(size: 35, minimalSize: 35),
                  Area(size: 300, minimalSize: 300),
                  Area(weight: 1)
                ]),
                children: [
                Padding(
                    padding: const EdgeInsets.only(top: 5, left: 3, right: 3),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "${_model.firstCurrency}/${_model.secondCurrency}",
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, top: 5),
                            child: Text("$change24H %",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 15,
                                    color: (change24H == 0
                                        ? Colors.grey
                                        : (change24H < 0
                                            ? Colors.red
                                            : Colors.green)),
                                    fontWeight: FontWeight.bold)),
                          )
                        ])),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 3, right: 3),
                        child: MultiSplitView(initialAreas: [
                          Area(weight: 1),
                          Area(minimalSize: 170, size: 170)
                        ], children: [
                          Column(children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      child: DefaultTabController(
                                          length: 2,
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[200],
                                            child: TabBar(
                                              indicatorColor: Colors.grey,
                                              tabs: const [
                                                SizedBox(
                                                  height: 30,
                                                  child:
                                                      Tab(child: Text("Buy")),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                  child:
                                                      Tab(child: Text("Sell")),
                                                ),
                                              ],
                                              labelColor: Colors.white,
                                              unselectedLabelColor:
                                                  Colors.grey[600],
                                              indicator: RectangularIndicator(
                                                bottomLeftRadius: 5,
                                                bottomRightRadius: 5,
                                                topLeftRadius: 5,
                                                topRightRadius: 5,
                                                color: activeTabColor,
                                              ),
                                              onTap: (id) {
                                                setState(() {
                                                  if (id == 0) {
                                                    activeTabColor =
                                                        Colors.green;
                                                  } else {
                                                    activeTabColor = Colors.red;
                                                  }
                                                });
                                              },
                                            ),
                                          ))),
                                ]),
                            Container(margin: const EdgeInsets.only(top: 5)),
                            InputQty(
                              showMessageLimit: false,
                              boxDecoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              textFieldDecoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.all(9),
                                labelText: "Price",
                                labelStyle: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]
                                ),
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                              ),
                              maxVal: double.maxFinite,
                              isIntrinsicWidth: false,
                              initVal: price,
                              minVal: 0,
                              steps: 1,
                              borderShape: BorderShapeBtn.none,
                              plusBtn: const Icon(Icons.add, size: 25),
                              minusBtn: const Icon(Icons.remove, size: 25),
                              btnColor1: Colors.grey[600]!,
                              btnColor2: Colors.grey[600]!,
                              onQtyChanged: (val) {
                                price = val?.ceilToDouble() ?? 0;
                              },
                            ),
                            Container(margin: const EdgeInsets.only(top: 5)),
                            InputQty(
                              showMessageLimit: false,
                              boxDecoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              textFieldDecoration: InputDecoration(
                                labelText:
                                    "Amount(${activeTabColor == Colors.red ? _model.firstCurrency : _model.secondCurrency})",
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                                labelStyle: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600]
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: const EdgeInsets.all(9),
                              ),
                              maxVal: _model.firstWallet.value!,
                              isIntrinsicWidth: false,
                              initVal: amount,
                              minVal: 0,
                              steps: 1,
                              borderShape: BorderShapeBtn.none,
                              plusBtn: const Icon(Icons.add, size: 25),
                              minusBtn: const Icon(Icons.remove, size: 25),
                              btnColor1: Colors.grey[600]!,
                              btnColor2: Colors.grey[600]!,
                              onQtyChanged: (val) {
                                amount = val?.ceilToDouble() ?? 0;
                              },
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 5),
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return GroupButton(
                                    controller: GroupButtonController(
                                      selectedIndex: 1,
                                      onDisablePressed: (i) => debugPrint(
                                          'Disable Button #$i pressed'),
                                    ),
                                    isRadio: true,
                                    options: GroupButtonOptions(
                                      selectedTextStyle: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                      unselectedTextStyle: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 13,
                                      ),
                                      buttonHeight: 20,
                                      buttonWidth: constraints.maxWidth / 4,
                                      selectedColor: Colors.grey[500],
                                      unselectedColor: Colors.grey[200],
                                      spacing: 0,
                                      direction: Axis.horizontal,
                                      groupingType: GroupingType.row,
                                    ),
                                    onSelected: (val, i, selected) {},
                                    buttons: const [
                                      '25%',
                                      '50%',
                                      '75%',
                                      '100%'
                                    ],
                                  );
                                })),
                            Container(margin: const EdgeInsets.only(top: 10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Available",
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    activeTabColor == Colors.green
                                        ? "${_model.secondWallet.value!} ${_model.secondCurrency}"
                                        : "${_model.firstWallet.value!} ${_model.firstCurrency}",
                                    style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 40),
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return MaterialButton(
                                    minWidth: constraints.maxWidth,
                                    color: activeTabColor,
                                    height: 50,
                                    shape:  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    //onPressed: onLogInButtonPressed,
                                    onPressed: () async {
                                      var uri = Uri.https(
                                          Constants.SERVER_URL,
                                          Constants.ServerApiEndpoints
                                              .CRYPTO_CREATE_ORDER);

                                      var body = CryptoCreateOrder(
                                          price: price.toString(),
                                          amount: amount.toString(),
                                          isBuy: activeTabColor == Colors.green,
                                          pair: _model.firstCurrency +
                                              _model.secondCurrency);

                                      var response =
                                          await _httpService.post(uri, body);
                                      var value =
                                          await response.stream.bytesToString();

                                      _updateData();
                                    },
                                    child: Text(
                                      activeTabColor == Colors.green
                                          ? "Buy ${_model.firstCurrency}"
                                          : "Sell ${_model.secondCurrency}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  );
                                }))
                          ]),
                          Column(
                            children: [
                              DataTable(
                                  horizontalMargin: 0,
                                  columnSpacing: 25,
                                  headingRowHeight: 45,
                                  dataRowHeight: 20,
                                  border: null,
                                  dividerThickness: 0.1,
                                  columns: <DataColumn>[
                                    DataColumn(
                                        label: Text(
                                      "Price\n(USDT)",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                      ),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      "Amount\n(${_model.secondCurrency})",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                      ),
                                    )),
                                  ],
                                  rows: _generateOrderBooks(
                                      _model.sellOrderBook ?? [], false)),
                              Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _model.marketTrades == null ||
                                            _model.marketTrades!.isEmpty
                                        ? '0'
                                        : _model.marketTrades!.first.startPrice
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Nunito',
                                        fontSize: 20,
                                        color: _model.marketTrades == null ||
                                                _model.marketTrades!.isEmpty
                                            ? Colors.red
                                            : (_model.marketTrades!.first.isBuy
                                                ? Colors.green
                                                : Colors.red)),
                                  )),
                              DataTable(
                                  horizontalMargin: 0,
                                  columnSpacing: 25,
                                  headingRowHeight: 0,
                                  dataRowHeight: 20,
                                  border: null,
                                  dividerThickness: 0.1,
                                  columns: <DataColumn>[
                                    DataColumn(
                                        label: Text(
                                      "",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                      ),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      "",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                      ),
                                    )),
                                  ],
                                  rows: _generateOrderBooks(
                                      _model.buyOrderBook ?? [], true)),
                            ],
                          ),
                        ]),
                      ),
                    )),
                SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(top: 5)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 5, top: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          "Open orders (${_model.userOpenOrders?.length ?? 0})",
                                          style: const TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.centerRight,
                                      child: MaterialButton(
                                        color: Colors.grey[300],
                                        height: 30,
                                        onPressed: () async {
                                          setState(() => isLoading = true);

                                          for (var openOrder
                                              in _model.userOpenOrders ?? []) {
                                            var uri = Uri.parse(
                                                "https://${Constants.SERVER_URL}/${Constants.ServerApiEndpoints.USER_CANCEL_ORDER}?id=${openOrder.id}&acronim=${_model.firstCurrency + _model.secondCurrency}");

                                            var res =
                                                await _httpService.get(uri);
                                          }
                                          await _updateData();
                                        },
                                        child: const Text(
                                          "Cancel all",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.6,
                                          ),
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                                Container(
                                    margin: const EdgeInsets.only(top: 10)),
                                SizedBox(
                                  width: double.infinity,
                                  child: DataTable(
                                      horizontalMargin: 0,
                                      columnSpacing: 25,
                                      headingRowHeight: 0,
                                      dataRowHeight: 85,
                                      border: null,
                                      dividerThickness: 0.5,
                                      columns: const <DataColumn>[
                                        DataColumn(label: Text("")),
                                        DataColumn(label: Text("")),
                                        DataColumn(label: Text("")),
                                      ],
                                      rows: _generateUserOpenOrders()),
                                )
                              ],
                            ))))
              ]));
  }
}
