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
  PageEnum currentBodyWidget = PageEnum.Login;

  @override
  Widget build(BuildContext context) {
    void changeAppBody(PageEnum pageEnum)
    {
      setState(() {
        currentBodyWidget = pageEnum;
      });
    }

    AppBar appBarWidget = AppBarWidget(callback: changeAppBody);

    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: appBarWidget,
          body: currentBodyWidget == PageEnum.Login ? LoginBodyWidget() : RegisterBodyWidget(),
        )
    );
  }

}
