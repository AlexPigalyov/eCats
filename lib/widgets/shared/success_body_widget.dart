import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:flutter/material.dart';

import '../../extensions/hex_color.dart';
import '../../models/enums/page_enum.dart';

class SuccessBodyWidget extends Center {
  final void Function(PageEnum, AppBarEnum, dynamic) screenCallback;

  SuccessBodyWidget({super.key, required this.screenCallback})
      : super(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Success",
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 25,
                    color: HexColor.fromHex('#5c6369')),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: FractionalOffset.center,
                child: MaterialButton(
                  color: HexColor.fromHex('#1b6ec2'),
                  height: 35,
                  onPressed: () {
                    screenCallback(
                        PageEnum.Profile, AppBarEnum.Authorized, null);
                  },
                  child: const Text(
                    "Back to Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nunito',
                      fontSize: 12.6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
}
