import 'package:flutter/material.dart';
import '../../Extensions/HexColor.dart';
import '../../Models/Enums/PageEnum.dart';

class AppBarWidget extends AppBar {
  final void Function(PageEnum) callback;
  AppBarWidget({super.key, required this.callback}):super (
      toolbarHeight: 50,
      backgroundColor: Colors.white,
      foregroundColor: HexColor.fromHex('#8391a2'),
      actions: [
        Row(
          children: [
            Container(
                margin: const EdgeInsets.only(right: 30),
                alignment: FractionalOffset.centerLeft,
                width: 150,
                child: const Image(image: AssetImage('assets/logo.png'))
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                IconButton(
                  iconSize: 32,
                  icon: Image.asset('icons/flags/png/us.png',
                      package: 'country_icons'),
                  onPressed: () {},
                ),
                MaterialButton(
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
                    callback(PageEnum.Login);
                  },
                ),
                MaterialButton(
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
                    callback(PageEnum.Register);
                  },
                ),
              ],
            )
          ],
        )
      ],
    );
  }
