import 'dart:core';

import 'package:ecats/extensions/hex_color.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:flutter/material.dart';

class AuthorizedAppBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  final void Function(PageModel?, bool, PageModel) screenCallback;

  const AuthorizedAppBarWidget({super.key, required this.screenCallback})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  State<AuthorizedAppBarWidget> createState() => _AuthorizedAppBarWidgetState();

  @override
  final Size preferredSize;
}

class _AuthorizedAppBarWidgetState extends State<AuthorizedAppBarWidget> {

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      backgroundColor: Colors.white,
      foregroundColor: HexColor.fromHex('#8391a2'),
      title: Container(
        height: 50,
        alignment: FractionalOffset.centerLeft,
      ),
      actions: [
        Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Image.asset('icons/flags/png/us.png',
                      package: 'country_icons'),
                  onPressed: () {},
                )))
      ],
    );
  }
}
