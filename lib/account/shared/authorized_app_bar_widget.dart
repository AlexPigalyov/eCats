import 'dart:core';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecats/extensions/hex_color.dart';
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthorizedAppBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  final void Function(PageEnum, AppBarEnum) screenCallback;

  const AuthorizedAppBarWidget({super.key, required this.screenCallback})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

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
        height: 50,
        alignment: FractionalOffset.centerLeft,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: const Icon(
              Icons.list,
              size: 32,
              color: Colors.black,
            ),
            items: <String>[].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            itemHeight: 48,
            itemPadding: const EdgeInsets.only(left: 16, right: 16),
            dropdownWidth: 160,
            dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
            dropdownDecoration:
                BoxDecoration(borderRadius: BorderRadius.circular(4)),
            dropdownElevation: 8,
            offset: const Offset(0, 8),
            isExpanded: false,
            iconSize: 24,
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              if (newValue != null && newValue == 'Logout') {
                _storage.delete(key: 'token').then((x) => widget.screenCallback(
                    PageEnum.Login, AppBarEnum.NonAuthorized));
              }
            },
          ),
        ),
      ),
      actions: [
        Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: SizedBox(
                child: IconButton(
              icon: Image.asset('icons/flags/png/us.png',
                  package: 'country_icons'),
              onPressed: () {},
            ))),
        Flexible(
            flex: 6,
            fit: FlexFit.loose,
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(right: 15, left: 15),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  customButton: const Icon(
                    Icons.person,
                    size: 32,
                  ),
                  items: <String>['Profile', 'Logout'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  itemHeight: 48,
                  itemPadding: const EdgeInsets.only(left: 16, right: 16),
                  dropdownWidth: 160,
                  dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                  dropdownDecoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(4)),
                  dropdownElevation: 8,
                  offset: const Offset(0, 8),
                  isExpanded: false,
                  iconSize: 24,
                  underline: const SizedBox(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      if (newValue == 'Logout') {
                        _storage.delete(key: 'token').then((x) =>
                            widget.screenCallback(
                                PageEnum.Login, AppBarEnum.NonAuthorized));
                      } else if (newValue == 'Profile') {
                        widget.screenCallback(
                            PageEnum.Profile, AppBarEnum.Authorized);
                      }
                    }
                  },
                ),
              ),
            ))
      ],
    );
  }
}
