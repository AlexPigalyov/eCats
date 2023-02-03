import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:ecats/extensions/hex_color.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthorizedAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final void Function(PageEnum, AppBarEnum) screenCallback;
  const AuthorizedAppBarWidget({
    super.key,
    required this.screenCallback
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  State<AuthorizedAppBarWidget> createState() => _AuthorizedAppBarWidgetState();

  @override
  final Size preferredSize;
}

class _AuthorizedAppBarWidgetState extends State<AuthorizedAppBarWidget> {

  final _storage = const FlutterSecureStorage();

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      backgroundColor: Colors.white,
      foregroundColor: HexColor.fromHex('#8391a2'),
      title: Container(
          width: 40,
          alignment: FractionalOffset.centerLeft,
          child: Flexible(
              flex: 0,
              fit: FlexFit.loose,
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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)
            ),
            child: DropdownButton<String>(
              icon: const Icon(Icons.person),
              iconSize: 42,
              underline: const SizedBox(),
              onChanged: (String? newValue)
              {
                if(newValue != null && newValue == 'Logout') {
                  _storage.delete(key: 'token')
                    .then((x) => widget.screenCallback(PageEnum.Login, AppBarEnum.NonAuthorized));
                }
              },
              items: <String>['Logout'].map((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}