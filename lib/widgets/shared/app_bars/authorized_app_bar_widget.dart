import 'dart:core';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecats/extensions/hex_color.dart';
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
              Icons.reorder,
              size: 32,
              color: Colors.black,
            ),
            items: <String>[
              'Markets',
              'Open Orders',
              'Closed Orders',
              'Wallets',
              'Income Transactions',
              'Income Wallets',
              'Withdraws',
              'Transfers',
              'Referals',
              'Events'
            ].map((String value) {
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
                switch (newValue) {
                  case 'Markets':
                    widget.screenCallback(
                        null,
                        false,
                        PageModel(
                            page: PageEnum.Pairs,
                            appBar: AppBarEnum.Authorized,
                            args: null));
                    break;
                  case 'Open Orders':
                    widget.screenCallback(
                        null,
                        false,
                        PageModel(
                            page: PageEnum.OpenOrders,
                            appBar: AppBarEnum.Authorized,
                            args: null));
                    break;
                  case 'Closed Orders':
                    widget.screenCallback(
                        null,
                        false,
                        PageModel(
                            page: PageEnum.ClosedOrders,
                            appBar: AppBarEnum.Authorized,
                            args: null));
                    break;
                  case 'Wallets':
                    widget.screenCallback(
                        null,
                        false,
                        PageModel(
                            page: PageEnum.Wallets,
                            appBar: AppBarEnum.Authorized,
                            args: null));
                    break;
                  case 'Income Wallets':
                    widget.screenCallback(
                        null,
                        false,
                        PageModel(
                            page: PageEnum.IncomeWallets,
                            appBar: AppBarEnum.Authorized,
                            args: null));
                    break;
                  case 'Income Transactions':
                    widget.screenCallback(
                        null,
                        false,
                        PageModel(
                            page: PageEnum.IncomeTransactions,
                            appBar: AppBarEnum.Authorized,
                            args: null));
                    break;
                  case 'Withdraws':
                    widget.screenCallback(
                        null,
                        false,
                        PageModel(
                            page: PageEnum.Wallets,
                            appBar: AppBarEnum.Authorized,
                            args: null));
                    break;
                  case 'Referals':
                    widget.screenCallback(
                        null,
                        false,
                        PageModel(
                            page: PageEnum.Refferals,
                            appBar: AppBarEnum.Authorized,
                            args: null));
                    break;
                  case 'Events':
                    widget.screenCallback(
                        null,
                        false,
                        PageModel(
                            page: PageEnum.Events,
                            appBar: AppBarEnum.Authorized,
                            args: null));
                    break;
                }
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
                                null,
                                false,
                                PageModel(
                                    page: PageEnum.Login,
                                    appBar: AppBarEnum.NonAuthorized,
                                    args: null)));
                      } else if (newValue == 'Profile') {
                        widget.screenCallback(
                            null,
                            false,
                            PageModel(
                                page: PageEnum.Profile,
                                appBar: AppBarEnum.Authorized,
                                args: null));
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
