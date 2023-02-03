import 'package:flutter/material.dart';
import 'package:ecats/extensions/hex_color.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/enums/app_bar_enum.dart';

class AuthorizedAppBarWidget extends AppBar {
  final void Function(PageEnum, AppBarEnum) screenCallback;
  AuthorizedAppBarWidget({super.key, required this.screenCallback}):super (
    toolbarHeight: 50,
    backgroundColor: Colors.white,
    foregroundColor: HexColor.fromHex('#8391a2'),
    title: Container(
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