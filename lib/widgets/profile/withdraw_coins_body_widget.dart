import 'dart:convert';

import 'package:ecats/Extensions/hex_color.dart';
import 'package:ecats/assets/constants.dart' as Constants;
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/requests/general_withdraw_request_model.dart';
import 'package:ecats/models/requests/shared/status_response_request_model.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:ecats/services/http_service.dart';
import 'package:ecats/widgets/shared/loading_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WithdrawCoinsBodyWidget extends StatefulWidget {
  final void Function(PageModel?, bool, PageModel) screenCallback;
  late String currency;

  WithdrawCoinsBodyWidget({super.key, required this.screenCallback});

  @override
  State<WithdrawCoinsBodyWidget> createState() =>
      _WithdrawCoinsBodyWidgetState();
}

class _WithdrawCoinsBodyWidgetState extends State<WithdrawCoinsBodyWidget> {
  final _httpService = HttpService();
  bool isLoading = true;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController amountCoinsController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  late GeneralWithdrawRequestModel _model;

  @override
  void initState() {
    super.initState();

    _updateData();
  }

  Future _updateData() async {
    setState(() => isLoading = true);

    var uri = Uri.parse(
        'https://${Constants.SERVER_URL}/${Constants.ServerApiEndpoints.WITHDRAW}?currency=${widget.currency}');
    var response = await _httpService.get(uri);
    var value = await response.stream.bytesToString();

    _model = GeneralWithdrawRequestModel.fromJson(jsonDecode(value));
    _refreshController.refreshCompleted();
    setState(() => isLoading = false);
  }

  @override
  Center build(BuildContext context) {
    return isLoading
        ? LoadingBodyWidget()
        : Center(
            child: SmartRefresher(
            onRefresh: () => _updateData(),
            controller: _refreshController,
            enablePullUp: true,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    alignment: FractionalOffset.centerLeft,
                    child: Text(
                      "Currency ${_model.currency}",
                      style: TextStyle(
                          fontSize: 15, color: HexColor.fromHex('#5c6369')),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    alignment: FractionalOffset.centerLeft,
                    child: Text(
                      "Balance ${_model.balance}",
                      style: TextStyle(
                          fontSize: 15, color: HexColor.fromHex('#5c6369')),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    alignment: FractionalOffset.centerLeft,
                    child: Text(
                      "Address",
                      style: TextStyle(
                          fontSize: 12.6, color: HexColor.fromHex('#5c6369')),
                    ),
                  ),
                  TextField(
                    controller: recipientController,
                    style: TextStyle(
                        fontSize: 12.6,
                        color: HexColor.fromHex('#5c6369'),
                        decorationThickness: 0),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      contentPadding: const EdgeInsets.all(9),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: HexColor.fromHex('#bdc0c4'), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: HexColor.fromHex('#dee2e6'), width: 1.0),
                      ),
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: 0.5,
                  ),
                  Container(
                    alignment: FractionalOffset.centerLeft,
                    child: Text(
                      "Amount",
                      style: TextStyle(
                          fontSize: 12.6, color: HexColor.fromHex('#5c6369')),
                    ),
                  ),
                  TextField(
                    controller: amountCoinsController,
                    style: TextStyle(
                        fontSize: 12.6,
                        color: HexColor.fromHex('#5c6369'),
                        decorationThickness: 0),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      contentPadding: const EdgeInsets.all(9),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: HexColor.fromHex('#bdc0c4'), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: HexColor.fromHex('#dee2e6'), width: 1.0),
                      ),
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: 0.5,
                  ),
                  Container(
                    alignment: FractionalOffset.centerLeft,
                    child: Text(
                      "Minimum amount: ${_model.amountMin ?? 0}",
                      style: TextStyle(
                          fontSize: 15, color: HexColor.fromHex('#5c6369')),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    alignment: FractionalOffset.centerLeft,
                    child: Text(
                      "Commission: ${_model.currency}",
                      style: TextStyle(
                          fontSize: 15, color: HexColor.fromHex('#5c6369')),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    alignment: FractionalOffset.centerLeft,
                    child: MaterialButton(
                      color: HexColor.fromHex('#1b6ec2'),
                      height: 35,
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        var model = GeneralWithdrawRequestModel(
                            address: recipientController.text,
                            currency: _model.currency,
                            amount: amountCoinsController.text);

                        var uri = Uri.parse(
                            'https://${Constants.SERVER_URL}/${Constants.ServerApiEndpoints.WITHDRAW}');
                        var response = await _httpService.post(uri, model);
                        var value = await response.stream.bytesToString();

                        var res = StatusResponseRequestModel.fromJson(
                            jsonDecode(value));

                        if (response.statusCode == 200) {
                          widget.screenCallback(
                              PageModel(
                                  page: PageEnum.Withdraw,
                                  appBar: AppBarEnum.Authorized,
                                  args: widget.currency),
                              true,
                              PageModel(
                                  page: PageEnum.Success,
                                  appBar: AppBarEnum.Authorized,
                                  args: null));
                        } else {
                          widget.screenCallback(
                              PageModel(
                                  page: PageEnum.Withdraw,
                                  appBar: AppBarEnum.Authorized,
                                  args: widget.currency),
                              true,
                              PageModel(
                                  page: PageEnum.Error,
                                  appBar: AppBarEnum.Authorized,
                                  args: res.status));
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: const Text(
                        "Send",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
  }
}
