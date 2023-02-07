import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:flutter/material.dart';

import '../../extensions/hex_color.dart';
import '../../models/enums/page_enum.dart';

class ErrorBodyWidget extends StatefulWidget {
  final void Function(PageEnum, AppBarEnum, dynamic) screenCallback;
  late String errorMessage;

  ErrorBodyWidget({super.key, required this.screenCallback});

  @override
  State<ErrorBodyWidget> createState() => _ErrorBodyWidgetState();
}

class _ErrorBodyWidgetState extends State<ErrorBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Error ${widget.errorMessage}",
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
                widget.screenCallback(
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
}
