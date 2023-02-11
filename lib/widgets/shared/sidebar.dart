import 'dart:convert';

import 'package:ecats/Extensions/hex_color.dart';
import 'package:ecats/assets/constants.dart' as Constants;
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/requests/profile_request_model.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:ecats/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:getwidget/components/drawer/gf_drawer_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SideBar extends StatefulWidget {
  final void Function(PageModel?, bool, PageModel) screenCallback;

  const SideBar({super.key, required this.screenCallback});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final _httpService = HttpService();
  bool isLoading = true;
  late ProfileRequestModel model;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future _updateData() async {
    setState(() => isLoading = true);

    var uri =
        Uri.https(Constants.SERVER_URL, Constants.ServerApiEndpoints.PROFILE);
    var response = await _httpService.get(uri);
    var value = await response.stream.bytesToString();

    model = ProfileRequestModel.fromJson(jsonDecode(value));

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const GFDrawer()
        : SizedBox(
      width: 230,
      child: GFDrawer(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: <Widget>[
            LimitedBox(
              maxHeight: 150,
              child: GFDrawerHeader(
                closeButton: IconButton(icon: Icon(Icons.close, color: HexColor.fromHex('#6C757D')), onPressed: () {  }),
                centerAlign: true,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                margin: const EdgeInsets.all(0),
                currentAccountPicture:
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    height: 64,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Text(model.username, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: HexColor.fromHex('#6C757D'),
                    )),
                  ],
                ),
              ),
            ),
            ListTile(
              dense: true,
              title: Row(
                children: [
                  const Icon(Icons.account_circle_outlined, size: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HexColor.fromHex('#6C757D'),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                widget.screenCallback(
                    null,
                    false,
                    PageModel(
                        page: PageEnum.Profile,
                        appBar: AppBarEnum.Authorized,
                        args: null));
              },
            ),
            ListTile(
              dense: true,
              title: Row(
                children: [
                  const Icon(Icons.cached_outlined, size: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Markets",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HexColor.fromHex('#6C757D'),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                widget.screenCallback(
                    null,
                    false,
                    PageModel(
                        page: PageEnum.Pairs,
                        appBar: AppBarEnum.Authorized,
                        args: null));
              },
            ),
            ListTile(
              dense: true,
              title: Row(
                children: [
                  const Icon(Icons.filter_none_outlined, size: 18),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Open Orders",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HexColor.fromHex('#6C757D'),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                widget.screenCallback(
                    null,
                    false,
                    PageModel(
                        page: PageEnum.OpenOrders,
                        appBar: AppBarEnum.Authorized,
                        args: null));
              },
            ),
            ListTile(
              dense: true,
              title: Row(
                children: [
                  const Icon(Icons.library_add_check_outlined, size: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Closed Orders",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HexColor.fromHex('#6C757D'),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                widget.screenCallback(
                    null,
                    false,
                    PageModel(
                        page: PageEnum.ClosedOrders,
                        appBar: AppBarEnum.Authorized,
                        args: null));
              },
            ),
            ListTile(
              dense: true,
              title: Row(
                children: [
                  const Icon(Icons.wallet_outlined, size: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Wallets",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HexColor.fromHex('#6C757D'),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                widget.screenCallback(
                    null,
                    false,
                    PageModel(
                        page: PageEnum.Wallets,
                        appBar: AppBarEnum.Authorized,
                        args: null));
              },
            ),
            ListTile(
              dense: true,
              title: Row(
                children: [
                  const Icon(Icons.wallet_outlined, size: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Income wallets",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HexColor.fromHex('#6C757D'),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                widget.screenCallback(
                    null,
                    false,
                    PageModel(
                        page: PageEnum.IncomeWallets,
                        appBar: AppBarEnum.Authorized,
                        args: null));
              },
            ),
            ListTile(
              dense: true,
              title: Row(
                children: [
                  const Icon(Icons.save_alt_outlined, size: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Income Transactions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HexColor.fromHex('#6C757D'),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                widget.screenCallback(
                    null,
                    false,
                    PageModel(
                        page: PageEnum.IncomeTransactions,
                        appBar: AppBarEnum.Authorized,
                        args: null));
              },
            ),
            ListTile(
              dense: true,
              title: Row(
                children: [
                  const Icon(Icons.outbond_outlined, size: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Withdraws",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HexColor.fromHex('#6C757D'),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                widget.screenCallback(
                    null,
                    false,
                    PageModel(
                        page: PageEnum.Wallets,
                        appBar: AppBarEnum.Authorized,
                        args: null));
              },
            ),
            ListTile(
              dense: true,
              title: Row(
                children: [
                  const Icon(Icons.swap_horiz_outlined, size: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Transfers",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HexColor.fromHex('#6C757D'),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              dense: true,
              title: Row(
                children: [
                  const Icon(Icons.supervised_user_circle_outlined, size: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Referrals",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HexColor.fromHex('#6C757D'),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                widget.screenCallback(
                    null,
                    false,
                    PageModel(
                        page: PageEnum.Refferals,
                        appBar: AppBarEnum.Authorized,
                        args: null));
              },
            ),
            ListTile(
              dense: true,
              title: Row(
                children: [
                  const Icon(Icons.event, size: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Events",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HexColor.fromHex('#6C757D'),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                widget.screenCallback(
                    null,
                    false,
                    PageModel(
                        page: PageEnum.Events,
                        appBar: AppBarEnum.Authorized,
                        args: null));
              },
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                dense: true,
                title: Row(
                  children: [
                    const Icon(Icons.logout, size: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: HexColor.fromHex('#6C757D'),
                        ),
                      ),
                    )
                  ],
                ),
                onTap: () {
                  _storage.delete(key: 'token').then((x) =>
                      widget.screenCallback(
                          null,
                          false,
                          PageModel(
                              page: PageEnum.Auth,
                              appBar: AppBarEnum.NonAuthorized,
                              args: null)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
