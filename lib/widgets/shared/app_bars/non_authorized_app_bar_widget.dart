import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:flutter/material.dart';

import '../../../extensions/hex_color.dart';

class NonAuthorizedAppBarWidget extends AppBar {
  final void Function(PageModel?, bool, PageModel) screenCallback;

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
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: HexColor.fromHex('#8391a2'),
                      ),
                    ),
                    onPressed: () {
                      screenCallback(
                          null,
                          false,
                          PageModel(
                              page: PageEnum.Login,
                              appBar: AppBarEnum.NonAuthorized,
                              args: null));
                    },
                  )),
              Flexible(
                  flex: 3,
                  child: MaterialButton(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: HexColor.fromHex('#8391a2'),
                      ),
                    ),
                    onPressed: () {
                      screenCallback(
                          null,
                          false,
                          PageModel(
                              page: PageEnum.Register,
                              appBar: AppBarEnum.NonAuthorized,
                              args: null));
                    },
                  ))
            ]);
}
