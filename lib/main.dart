import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/account/login_body_widget.dart';
import 'package:ecats/account/loading_body_widget.dart';
import 'package:ecats/account/profile_body_widget.dart';
import 'package:ecats/account/register_body_widget.dart';
import 'package:ecats/account/shared/authorized_app_bar_widget.dart';
import 'package:ecats/account/shared/non_authorized_app_bar_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  late AppBar currentAppBarWidget;

  bool _isLoading = true;
  bool _isAuthorized = false;

  late Map<PageEnum, Widget> bodies;
  late Map<AppBarEnum, AppBar> appBars;

  @override
  void initState() {
    super.initState();
    //Only while develop
    HttpOverrides.global = MyHttpOverrides();
    dataLoadFunction();
  }

  dataLoadFunction() async {
    //Initialization AppBars and Bodies
    appBars = <AppBarEnum, AppBar>{
      AppBarEnum.Authorized: AuthorizedAppBarWidget(screenCallback: changeScreen),
      AppBarEnum.NonAuthorized: NonAuthorizedAppBarWidget(screenCallback: changeScreen)
    };

    bodies = <PageEnum, Widget>{
      PageEnum.Loading: LoadingBodyWidget(),
      PageEnum.Login: LoginBodyWidget(screenCallback: changeScreen),
      PageEnum.Register: RegisterBodyWidget(screenCallback: changeScreen),
      PageEnum.Profile: ProfileBodyWidget(screenCallback: changeScreen)
    };

    //Fetch some data
    await _storage.deleteAll();
    var token = await _storage.read(key: 'token');
    setState(() => _isAuthorized = token == null ? false : true);

    await Future.delayed(const Duration(seconds: 3));

    setState(() => _isLoading = false);

    //Set current AppBar
    currentAppBarWidget = (_isAuthorized
        ? appBars[AppBarEnum.Authorized]
        : appBars[AppBarEnum.NonAuthorized]
    )!;

    //Set current Body
    currentBodyWidget = (_isAuthorized
        ? bodies[PageEnum.Profile]
        : bodies[PageEnum.Login]
    )!;
  }


  changeScreen(PageEnum pageEnum, AppBarEnum appBarEnum) => setState(() {
      currentBodyWidget = bodies[pageEnum]!;
      currentAppBarWidget = appBars[appBarEnum]!;
    });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _isLoading
            ? Scaffold(body: bodies[PageEnum.Loading])
            : Scaffold(appBar: currentAppBarWidget, body: currentBodyWidget)
    );
  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
