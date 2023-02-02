import 'package:ecats/Models/RegisterModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_model_form_validation/flutter_model_form_validation.dart';

import '../Extensions/HexColor.dart';

import 'package:http/http.dart' as http;

class RegisterBodyWidget extends StatefulWidget {
  const RegisterBodyWidget({super.key});

  @override
  State<RegisterBodyWidget> createState() => _RegisterBodyWidgetState();
}

class _RegisterBodyWidgetState extends State<RegisterBodyWidget> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();

  late RegisterModel model;

  @override
  Center build(BuildContext context) {
    void onRegisterButtonPressed() async {

      model = RegisterModel(
          email: emailController.text,
          password: passwordController.text,
          passwordConfirm: passwordConfirmController.text);

      if(ModelState.isValid<RegisterModel>(model)) {
        var url = Uri.http('ecats.online', 'Register');
        var response = await http.post(url, body: model);
      }
      else {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Validation rules'),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(children: <Widget>[
                  for (String key in ModelState.errors.keys)
                    ListTile(
                      leading: const Icon(Icons.error, color: Colors.redAccent),
                      title: Text(ModelState.errors[key]!.error)
                  )
                ])
              ),
              actions: <Widget>[
                MaterialButton(
                  child: const Text('Ok'),
                  onPressed: () => Navigator.of(context).pop())
              ],
            );
          }
        );
      }
    }

    return Center(
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
                  controller: emailController,
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
                  controller: passwordController,
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
                  controller: passwordConfirmController,
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
            margin: const EdgeInsets.only(left: 15, top: 15, right: 15),
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
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
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
                        Flexible(
                          flex: 0,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Image(
                              image: AssetImage('assets/google.png'),
                              width: 20,
                              height: 50,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Text(
                              "Register with Google",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: HexColor.fromHex('#6C757D'),
                                fontFamily: 'Nunito',
                                fontSize: 12.6,
                              ),
                            )
                        ),

                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  alignment: FractionalOffset.centerLeft,
                  width: 210,
                  height: 35,
                  child: MaterialButton(
                    color: HexColor.fromHex('#1976f2'),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 0,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Image(
                              image: AssetImage('assets/facebook.png'),
                              width: 20,
                              height: 50,
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Register with Facebook",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                              fontSize: 12.6,
                            ),
                          ),
                        )
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
  }

}
