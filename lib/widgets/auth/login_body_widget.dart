import 'package:ecats/assets/constants.dart' as Constants;
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/requests/login_request_model.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:ecats/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../extensions/hex_color.dart';

class LoginBodyWidget extends StatefulWidget {
  final void Function(PageModel?, bool, PageModel) screenCallback;

  const LoginBodyWidget({super.key, required this.screenCallback});

  @override
  State<LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<LoginBodyWidget> {
  final _storage = const FlutterSecureStorage();
  final _httpService = HttpService();

  LoginRequestModel model = LoginRequestModel.createDefault();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onLogInButtonPressed() async {
    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      model = LoginRequestModel(
          login: emailController.text,
          password: passwordController.text,
          rememberMe: true);

      var uri =
          Uri.https(Constants.SERVER_URL, Constants.ServerApiEndpoints.LOGIN);

      var response = await _httpService.post(uri, model);

      if (response.statusCode == 200) {
        await _storage.write(
            key: 'token', value: await response.stream.bytesToString());

        widget.screenCallback(
            null,
            false,
            PageModel(
                page: PageEnum.Profile,
                appBar: AppBarEnum.Authorized,
                args: null));
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Center build(BuildContext context) {
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
                  "Log in",
                  style: TextStyle(
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
                  "Use a local account to log in.",
                  style: TextStyle(
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
                  "Email or Username",
                  style: TextStyle(
                      fontSize: 12.6, color: HexColor.fromHex('#5c6369')),
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
                      fontSize: 12.6, color: HexColor.fromHex('#5c6369')),
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
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 12, top: 10),
          alignment: FractionalOffset.centerLeft,
          child: MaterialButton(
            color: HexColor.fromHex('#1b6ec2'),
            height: 35,
            onPressed: onLogInButtonPressed,
            child: const Text(
              "Log in",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.6,
              ),
            ),
          ),
        ),
        Container(
          height: 30,
          margin: const EdgeInsets.only(top: 5),
          alignment: Alignment.centerLeft,
          child: MaterialButton(
            child: Text(
              "Forgot your password?",
              style: TextStyle(
                fontSize: 12.6,
                color: HexColor.fromHex('#6C757D'),
              ),
            ),
            onPressed: () {},
          ),
        ),
        Container(
          height: 30,
          alignment: FractionalOffset.topLeft,
          child: MaterialButton(
            child: Text(
              "Register as a new user",
              style: TextStyle(
                fontSize: 12.6,
                color: HexColor.fromHex('#6C757D'),
              ),
            ),
            onPressed: () {
              widget.screenCallback(
                  null,
                  false,
                  PageModel(
                      page: PageEnum.Register,
                      appBar: AppBarEnum.NonAuthorized,
                      args: null));
            },
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Text(
            "Use another service to log in.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.75,
              color: HexColor.fromHex('#6C757D'),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
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
                  width: 185,
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
                              "Log in with Google",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: HexColor.fromHex('#6C757D'),
                                fontSize: 12.6,
                              ),
                            ))
                      ],
                    ),
                    onPressed: () {},
                  ),
                )),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                padding: const EdgeInsets.only(left: 12, right: 12),
                alignment: FractionalOffset.centerLeft,
                width: 195,
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
                            "Log in with Facebook",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.6,
                            ),
                          ))
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
