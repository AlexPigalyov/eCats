import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:flutter/material.dart';

import '../../extensions/hex_color.dart';
import '../../models/enums/page_enum.dart';

class NonAuthorizedAppBarWidget extends AppBar {
  final void Function(PageEnum, AppBarEnum, dynamic) screenCallback;

  NonAuthorizedAppBarWidget({super.key, required this.screenCallback})
      : super(
            toolbarHeight: 50,
            backgroundColor: Colors.white,
            foregroundColor: HexColor.fromHex('#8391a2'),
            title: SizedBox(
                width: 50,
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                  height: 32,
                )),
            actions: <Widget>[
              Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: SizedBox(
                      child: IconButton(
                    icon: Image.asset('icons/flags/png/us.png',
                        package: 'country_icons'),
                    onPressed: () {},
                  ))),
              Flexible(
                  flex: 3,
                  child: MaterialButton(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: HexColor.fromHex('#8391a2'),
                      ),
                    ),
                    onPressed: () {
                      screenCallback(
                          PageEnum.Login, AppBarEnum.NonAuthorized, null);
                    },
                  )),
              Flexible(
                  flex: 3,
                  child: MaterialButton(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: HexColor.fromHex('#8391a2'),
                      ),
                    ),
                    onPressed: () {
                      screenCallback(
                          PageEnum.Register, AppBarEnum.NonAuthorized, null);
                    },
                  ))
            ]);
}
