import 'package:ecats/Extensions/HexColor.dart';
import 'package:ecats/Models/Enums/AppBarEnum.dart';
import 'package:ecats/Models/Enums/PageEnum.dart';
import 'package:flutter/material.dart';

class AuthorizedAppBarWidget extends AppBar {
  final void Function(PageEnum, AppBarEnum) callback;
  AuthorizedAppBarWidget({super.key, required this.callback}):super (
    toolbarHeight: 50,
    backgroundColor: Colors.white,
    foregroundColor: HexColor.fromHex('#8391a2'),
    title: Flexible(
      flex: 2,
      fit: FlexFit.loose,
      child: Container(
        width: 40,
        alignment: FractionalOffset.centerLeft,
        child: IconButton(
          icon: const Icon(
            Icons.list,
            color: Colors.black,
            size: 24.0
          ),
          onPressed: () {},
        )
      )
    ),
    actions: [
      Flexible(
        flex: 2,
        fit: FlexFit.loose,
        child: SizedBox(
          child: IconButton(
            icon: Image.asset('icons/flags/png/us.png', package: 'country_icons'),
            onPressed: () {},
          )
        )
      ),
      Flexible(
        flex: 3,
        fit: FlexFit.loose,
        child: SizedBox(
          child: IconButton(
            icon: const Icon(
                Icons.person,
                size: 32.0
            ),
            onPressed: () {},
          )
        )
      )
    ]
  );
}