import 'package:ecats/Account/LoadingBodyWidget.dart';
import 'package:ecats/Account/LoginBodyWidget.dart';
import 'package:ecats/Account/ProfileBodyWidget.dart';
import 'package:ecats/Account/RegisterBodyWidget.dart';
import 'package:ecats/Account/Shared/AuthorizedAppBarWidget.dart';
import 'package:ecats/Account/Shared/NonAuthorizedAppBarWidget.dart';
import 'package:ecats/Models/Enums/AppBarEnum.dart';
import 'package:ecats/Models/Enums/PageEnum.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Widget currentBodyWidget;
  late AppBar currentAppBarWidget;
  bool _isLoading = true;
  bool _isAuthorized = false;

  Map bodys = <PageEnum, Widget>{
    PageEnum.Loading: LoadingBodyWidget(),
    PageEnum.Login: const LoginBodyWidget(),
    PageEnum.Register: const RegisterBodyWidget(),
    PageEnum.Profile: const ProfileBodyWidget()
  };

  late Map<AppBarEnum, AppBar> appBars;

  @override
  void initState() {
    super.initState();
    dataLoadFunction();
  }

  dataLoadFunction() async {
    setState(() {
      _isLoading = true;
      currentBodyWidget = bodys[PageEnum.Loading];
    });

    //Fetch some data
    //_isAuthorized = false/true
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isLoading = false;
      currentBodyWidget = bodys[PageEnum.Login];
    });
  }

  void changeAppBody(PageEnum pageEnum, AppBarEnum appBarEnum)
  {
    setState(() {
      currentBodyWidget = bodys[pageEnum];
      currentAppBarWidget = appBars[appBarEnum]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    appBars = <AppBarEnum, AppBar>{
      AppBarEnum.Authorized: AuthorizedAppBarWidget(callback: changeAppBody),
      AppBarEnum.NonAuthorized: NonAuthorizedAppBarWidget(callback: changeAppBody)
    };

    currentAppBarWidget = (_isAuthorized ?
        appBars[AppBarEnum.Authorized] :
        appBars[AppBarEnum.NonAuthorized])!;

    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _isLoading
            ? Scaffold(body: currentBodyWidget)
            : Scaffold(appBar: currentAppBarWidget, body: currentBodyWidget)
    );
  }

}
