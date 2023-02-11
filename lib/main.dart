import 'dart:io';

import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:ecats/widgets/auth/login_body_widget.dart';
import 'package:ecats/widgets/auth/register_body_widget.dart';
import 'package:ecats/widgets/profile/closed_orders_body_widget.dart';
import 'package:ecats/widgets/profile/events_body_widget.dart';
import 'package:ecats/widgets/profile/income_transactions_body_widget.dart';
import 'package:ecats/widgets/profile/income_wallets_body_widget.dart';
import 'package:ecats/widgets/profile/open_orders_body_widget.dart';
import 'package:ecats/widgets/profile/profile_body_widget.dart';
import 'package:ecats/widgets/profile/send_body_widget.dart';
import 'package:ecats/widgets/profile/send_coins_body_widget.dart';
import 'package:ecats/widgets/profile/user_refferals_body_widget.dart';
import 'package:ecats/widgets/profile/wallets_body_widget.dart';
import 'package:ecats/widgets/profile/withdraw_coins_body_widget.dart';
import 'package:ecats/widgets/shared/app_bars/authorized_app_bar_widget.dart';
import 'package:ecats/widgets/shared/app_bars/non_authorized_app_bar_widget.dart';
import 'package:ecats/widgets/shared/error_body_widget.dart';
import 'package:ecats/widgets/shared/loading_body_widget.dart';
import 'package:ecats/widgets/shared/sidebar.dart';
import 'package:ecats/widgets/shared/success_body_widget.dart';
import 'package:ecats/widgets/trade/crypto_trade_body_widget.dart';
import 'package:ecats/widgets/trade/pairs_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _storage = const FlutterSecureStorage();

  late Widget currentBodyWidget;
  late PreferredSizeWidget currentAppBarWidget;
  late List<PageModel>? previousPages;
  bool _isLoading = true;
  bool _isAuthorized = false;

  late Map<PageEnum, Widget> bodies;
  late Map<AppBarEnum, PreferredSizeWidget> appBars;

  @override
  void initState() {
    dataLoadFunction();
    super.initState();
    //Only while develop
    HttpOverrides.global = MyHttpOverrides();
  }

  dataLoadFunction() async {
    //Initialization AppBars and Bodies
    bodies = <PageEnum, Widget>{
      PageEnum.Loading: LoadingBodyWidget(),
      PageEnum.Login: LoginBodyWidget(screenCallback: changeScreen),
      PageEnum.Register: RegisterBodyWidget(screenCallback: changeScreen),
      PageEnum.Profile: ProfileBodyWidget(screenCallback: changeScreen),
      PageEnum.OpenOrders: const OpenOrdersBodyWidget(),
      PageEnum.ClosedOrders: const ClosedOrdersBodyWidget(),
      PageEnum.IncomeTransactions: const IncomeTransactionsBodyWidget(),
      PageEnum.Events: const EventsBodyWidget(),
      PageEnum.Refferals: const UserRefferalsBodyWidget(),
      PageEnum.Send: SendBodyWidget(screenCallback: changeScreen),
      PageEnum.SendCoins: SendCoinsBodyWidget(screenCallback: changeScreen),
      PageEnum.Success: SuccessBodyWidget(screenCallback: changeScreen),
      PageEnum.Error: ErrorBodyWidget(screenCallback: changeScreen),
      PageEnum.Wallets: WalletsBodyWidget(screenCallback: changeScreen),
      PageEnum.IncomeWallets:
          IncomeWalletsBodyWidget(screenCallback: changeScreen),
      PageEnum.Withdraw: WithdrawCoinsBodyWidget(screenCallback: changeScreen),
      PageEnum.Pairs: PairsBodyWidget(screenCallback: changeScreen),
      PageEnum.CryptoTrade: CryptoTradeBodyWidget(screenCallback: changeScreen)
    };

    appBars = <AppBarEnum, PreferredSizeWidget>{
      AppBarEnum.Authorized:
          AuthorizedAppBarWidget(screenCallback: changeScreen),
      AppBarEnum.NonAuthorized:
          NonAuthorizedAppBarWidget(screenCallback: changeScreen)
    };

    previousPages = <PageModel>[];

    //Fetch some data
    //await _storage.deleteAll();
    var token = await _storage.read(key: 'token');

    setState(() => _isAuthorized = token == null ? false : true);

    await Future.delayed(const Duration(seconds: 3));

    setState(() => _isLoading = false);

    //Set current AppBar
    currentAppBarWidget = (_isAuthorized
        ? appBars[AppBarEnum.Authorized]
        : appBars[AppBarEnum.NonAuthorized])!;

    //Set current Body
    currentBodyWidget =
        (_isAuthorized ? bodies[PageEnum.Profile] : bodies[PageEnum.Login])!;
  }

  changeScreen(
          PageModel? callPage, bool saveCallPageAsPrevious, PageModel toPage) =>
      setState(() {
        if (saveCallPageAsPrevious) {
          if (previousPages!.isNotEmpty && previousPages!.length == 3) {
            previousPages!.removeAt(0);
          }
          previousPages!.add(callPage!);
        }

        switch (toPage.page) {
          case PageEnum.SendCoins:
            (bodies[toPage.page] as SendCoinsBodyWidget).currency =
                toPage.args as String;
            break;
          case PageEnum.Error:
            (bodies[toPage.page] as ErrorBodyWidget).errorMessage =
                toPage.args as String;
            break;
          case PageEnum.Withdraw:
            (bodies[toPage.page] as WithdrawCoinsBodyWidget).currency =
                toPage.args as String;
            break;
          case PageEnum.CryptoTrade:
            (bodies[toPage.page] as CryptoTradeBodyWidget).acronim =
                toPage.args as String;
            break;
        }
        currentBodyWidget = bodies[toPage.page]!;
        currentAppBarWidget = appBars[toPage.appBar]!;
      });

  Future<bool> _onBackPressed() {
    if (previousPages!.isNotEmpty) {
      if (currentBodyWidget == bodies[PageEnum.Register] ||
          currentBodyWidget == bodies[PageEnum.Login]) {
        Navigator.pop(context, false);
        return Future.value(true);
      } else {
        changeScreen(null, false, previousPages!.last);
        previousPages!.removeLast();
        return Future.value(false);
      }
    }

    if (Platform.isIOS) {
      exit(0);
    }

    SystemNavigator.pop();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        headerBuilder: () => const WaterDropHeader(),
        footerBuilder: () => const ClassicFooter(),
        headerTriggerDistance: 80.0,
        springDescription:
            const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
        maxOverScrollExtent: 30,
        maxUnderScrollExtent: 0,
        enableScrollWhenRefreshCompleted: true,
        enableLoadingWhenFailed: true,
        hideFooterWhenNotFull: false,
        enableBallisticLoad: true,
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Nunito',
            primarySwatch: Colors.blue,
          ),
          home: WillPopScope(
              onWillPop: _onBackPressed,
              child: _isLoading
                  ? Scaffold(body: bodies[PageEnum.Loading])
                  : Scaffold(
                      appBar: currentAppBarWidget,
                      body: currentBodyWidget,
                      drawer: currentAppBarWidget ==
                              appBars[AppBarEnum.Authorized]
                          ? SideBar(screenCallback: changeScreen)
                          : null,
                    )),
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
