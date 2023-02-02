import 'package:flutter/material.dart';
import '../../Extensions/HexColor.dart';
import '../../Models/Enums/PageEnum.dart';

class AppBarWidget extends AppBar {
  final void Function(PageEnum) callback;
  AppBarWidget({super.key, required this.callback}):super (
    toolbarHeight: 50,
    backgroundColor: Colors.white,
    foregroundColor: HexColor.fromHex('#8391a2'),
    title: Flexible(
      flex: 0,
      fit: FlexFit.loose,
      child: SizedBox(
        width: 50,
        child: Image.asset('assets/logo.png', fit: BoxFit.contain, height: 32,)
      ),
    ),
    actions: <Widget>[
      Flexible(
        flex: 2,
        fit: FlexFit.loose,
        child: SizedBox(
          child: IconButton(
            icon: Image.asset('icons/flags/png/us.png', package: 'country_icons'),
            onPressed: () {},
          )
        )
      ),
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
            callback(PageEnum.Login);
          },
        )
      ),
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
            callback(PageEnum.Register);
          },
        )
      )
    ]
  );
}
