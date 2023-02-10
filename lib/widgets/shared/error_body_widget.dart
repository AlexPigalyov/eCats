import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:flutter/material.dart';

import '../../extensions/hex_color.dart';

class ErrorBodyWidget extends StatefulWidget {
  final void Function(PageModel?, bool, PageModel) screenCallback;
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
            style: TextStyle(fontSize: 25, color: HexColor.fromHex('#5c6369')),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: FractionalOffset.center,
            child: MaterialButton(
              color: HexColor.fromHex('#1b6ec2'),
              height: 35,
              onPressed: () {
                widget.screenCallback(
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
}
