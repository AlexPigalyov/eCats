import 'package:ecats/Account/LoadingBodyWidget.dart';
import 'package:ecats/Account/LoginBodyWidget.dart';
import 'package:ecats/Account/RegisterBodyWidget.dart';
import 'package:ecats/Account/Shared/AppBarWidget.dart';
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
  Center currentBodyWidget = const Center();
  bool _isLoading = true;

  Map bodys = <PageEnum, Center>{
    PageEnum.Loading: LoadingBodyWidget(),
    PageEnum.Login: LoginBodyWidget(),
    PageEnum.Register: RegisterBodyWidget()
  };

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
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isLoading = false;
      currentBodyWidget = bodys[PageEnum.Login];
    });
  }

  @override
  Widget build(BuildContext context) {
    void changeAppBody(PageEnum pageEnum)
    {
      setState(() {
        currentBodyWidget = bodys[pageEnum];
      });
    }

    AppBar appBarWidget = AppBarWidget(callback: changeAppBody);

    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _isLoading 
            ? Scaffold(body: currentBodyWidget)
            : Scaffold(appBar: appBarWidget, body: currentBodyWidget)
    );
  }

}
