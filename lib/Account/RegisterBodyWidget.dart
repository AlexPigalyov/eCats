
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Extensions/HexColor.dart';

class RegisterBodyWidget extends Center {
  RegisterBodyWidget({super.key}):super(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              Container(
                alignment: FractionalOffset.centerLeft,
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    fontSize: 23.7,
                    color: HexColor.fromHex('#6C757D'),
                  ),
                ),
              ),
              Container(
                alignment: FractionalOffset.centerLeft,
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  "Create a new account.",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    fontSize: 15.75,
                    color: HexColor.fromHex('#6C757D'),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Divider(color: HexColor.fromHex('#6C757D')),
              ),
              Container(
                alignment: FractionalOffset.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12.6,
                      color: HexColor.fromHex('#5c6369')),
                ),
              ),
              TextField(
                style: TextStyle(
                    fontSize: 12.6,
                    color: HexColor.fromHex('#5c6369'),
                    decorationThickness: 0),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  contentPadding: const EdgeInsets.all(9),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor.fromHex('#bdc0c4'), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor.fromHex('#dee2e6'), width: 1.0),
                  ),
                ),
                cursorColor: Colors.black,
                cursorWidth: 0.5,
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                alignment: FractionalOffset.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12.6,
                      color: HexColor.fromHex('#5c6369')),
                ),
              ),
              TextField(
                obscureText: true,
                autocorrect: false,
                style: TextStyle(
                    fontSize: 12.6,
                    color: HexColor.fromHex('#5c6369'),
                    decorationThickness: 0),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  contentPadding: const EdgeInsets.all(9),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor.fromHex('#bdc0c4'), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor.fromHex('#dee2e6'), width: 1.0),
                  ),
                ),
                cursorColor: Colors.black,
                cursorWidth: 0.5,
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                alignment: FractionalOffset.centerLeft,
                child: Text(
                  "Confirm password",
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12.6,
                      color: HexColor.fromHex('#5c6369')),
                ),
              ),
              TextField(
                obscureText: true,
                autocorrect: false,
                style: TextStyle(
                    fontSize: 12.6,
                    color: HexColor.fromHex('#5c6369'),
                    decorationThickness: 0),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  contentPadding: const EdgeInsets.all(9),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor.fromHex('#bdc0c4'), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor.fromHex('#dee2e6'), width: 1.0),
                  ),
                ),
                cursorColor: Colors.black,
                cursorWidth: 0.5,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 12, top: 15),
          alignment: FractionalOffset.centerLeft,
          child: MaterialButton(
            color: HexColor.fromHex('#1b6ec2'),
            height: 35,
            child: const Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Nunito',
                fontSize: 12.6,
              ),
            ),
            onPressed: () {},
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 15, top: 15),
          child: Text(
            "Use another service to register.",
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              fontSize: 15.75,
              color: HexColor.fromHex('#6C757D'),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 12, right: 12,top: 5, bottom: 5),
          child: Divider(color: HexColor.fromHex('#6C757D')),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 12),
              alignment: FractionalOffset.centerLeft,
              width: 195,
              height: 35,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(width: 1, color: Colors.black),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Image(
                        image: AssetImage('assets/google.png'),
                        width: 20,
                        height: 50,
                      ),
                    ),
                    Text(
                      "Register with Google",
                      style: TextStyle(
                        color: HexColor.fromHex('#6C757D'),
                        fontFamily: 'Nunito',
                        fontSize: 12.6,
                      ),
                    )
                  ],
                ),
                onPressed: () {},
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 12),
              alignment: FractionalOffset.centerLeft,
              width: 210,
              height: 35,
              child: MaterialButton(
                color: HexColor.fromHex('#1976f2'),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Image(
                        image: AssetImage('assets/facebook.png'),
                        width: 20,
                        height: 50,
                      ),
                    ),
                    const Text(
                      "Register with Facebook",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                        fontSize: 12.6,
                      ),
                    )
                  ],
                ),
                onPressed: () {},
              ),
            ),
          ],
        )
      ],
    )
  );
}