import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:flutter/material.dart';

import '../../extensions/hex_color.dart';

class SuccessBodyWidget extends Center {
  final void Function(PageModel?, bool, PageModel) screenCallback;

  SuccessBodyWidget({super.key, required this.screenCallback})
      : super(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Success",
                style:
                    TextStyle(fontSize: 25, color: HexColor.fromHex('#5c6369')),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: FractionalOffset.center,
                child: MaterialButton(
                  color: HexColor.fromHex('#1b6ec2'),
                  height: 35,
                  onPressed: () {
                    screenCallback(
                        null,
                        false,
                        PageModel(
                            page: PageEnum.Profile,
                            appBar: AppBarEnum.Authorized,
                            args: null));
                  },
                  child: const Text(
                    "Back to Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
}
