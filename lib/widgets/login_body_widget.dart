import 'package:division/division.dart';
import 'package:ecats/assets/constants.dart' as Constants;
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/requests/login_request_model.dart';
import 'package:ecats/models/requests/register_request_model.dart';
import 'package:ecats/models/requests/request_model.dart';
import 'package:ecats/models/shared/page_model.dart';
import 'package:ecats/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:getwidget/types/gf_border_type.dart';
import 'package:niku/namespace.dart' as n;

class AuthBodyWidget extends StatefulWidget {
  final void Function(PageModel?, bool, PageModel) screenCallback;

  const AuthBodyWidget({super.key, required this.screenCallback});

  @override
  State<AuthBodyWidget> createState() => _AuthBodyWidgetState();
}

class _AuthBodyWidgetState extends State<AuthBodyWidget> {
  final _storage = const FlutterSecureStorage();
  final _httpService = HttpService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String userNameLogin = '';
  String passwordLogin = '';

  String userNameRegister = '';
  String passwordRegister = '';
  String passwordConfirmRegister = '';
  String referalIdRegister = '';

  bool _isLoginUsernameFieldActive = false;
  bool _isLoginPasswordFieldActive = false;

  bool _isRegisterUsernameFieldActive = false;
  bool _isRegisterPasswordFieldActive = false;
  bool _isRegisterPasswordConfirmFieldActive = false;
  bool _isRegisterReferalIdFieldActive = false;

  bool isLogin = true;
  Color activeTabColor = Colors.blue;

  final inputFieldStyle = (bool isActive, TxtStyle activeStyle) => TxtStyle()
    ..textColor(Colors.black)
    ..textAlign.left()
    ..fontSize(16)
    ..padding(horizontal: 15, vertical: 15)
    ..margin(horizontal: 50, vertical: 10)
    ..borderRadius(all: 10)
    ..alignment.center()
    ..background.color(Colors.grey[200]!)
    ..animate(300, Curves.easeOut)
    ..add(isActive ? activeStyle : null, override: true);

  final TxtStyle inputFieldActiveStyle = TxtStyle()
    ..background.color(Colors.blue)
    ..bold(true)
    ..textColor(Colors.white);

  final TxtStyle submitButtonStyle = TxtStyle()
    ..textColor(Colors.white)
    ..bold()
    ..ripple(true, splashColor: Colors.white.withOpacity(0.1))
    ..alignment.center()
    ..textAlign.center()
    ..width(200)
    ..background.color(Colors.blue)
    ..borderRadius(all: 10)
    ..margin(top: 30, horizontal: 50)
    ..padding(vertical: 15)
    ..elevation(10, opacity: 0.5);

  final titleStyle = TxtStyle()
    ..fontSize(24)
    ..bold()
    ..margin(bottom: 30, horizontal: 50)
    ..alignment.center();

  void onAuthButtonPressed() async {
    RequestModel model;

    if (isLogin) {
      if (userNameLogin.trim().isEmpty && passwordLogin.trim().isEmpty) {
        GFToast.showToast('Fields cannot be empty', context,
            toastPosition: GFToastPosition.BOTTOM,
            textStyle: const TextStyle(
                fontSize: 16,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                color: Colors.white),
            backgroundColor: Colors.blue,
            toastBorderRadius: 5.0,
            trailing: const Icon(
              Icons.error,
              color: GFColors.DANGER,
            ));
        return;
      } else {
        model = LoginRequestModel(
            login: userNameLogin, password: passwordLogin, rememberMe: true);
      }
    } else {
      model = RegisterRequestModel(
          email: userNameRegister,
          password: passwordRegister,
          confirmPassword: passwordConfirmRegister,
          refId: int.tryParse(
              referalIdRegister.isNotEmpty ? referalIdRegister : '0'));
    }

    var uri = Uri.https(
        Constants.SERVER_URL,
        isLogin
            ? Constants.ServerApiEndpoints.LOGIN
            : Constants.ServerApiEndpoints.REGISTER);

    var response = await _httpService.post(uri, model);

    var result = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      await _storage.write(key: 'token', value: result);

      widget.screenCallback(
          null,
          false,
          PageModel(
              page: PageEnum.Profile,
              appBar: AppBarEnum.Authorized,
              args: null));
    } else {
      GFToast.showToast(result, context,
          toastPosition: GFToastPosition.BOTTOM,
          textStyle: const TextStyle(
              fontSize: 16,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              color: Colors.white),
          backgroundColor: Colors.blue,
          toastBorderRadius: 5.0,
          trailing: const Icon(
            Icons.error,
            color: GFColors.DANGER,
          ));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 25),
        child: DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                        child: TabBar(
                          indicatorColor: Colors.grey,
                          tabs: const [
                            SizedBox(
                              height: 30,
                              child: Tab(child: Text("Log in")),
                            ),
                            SizedBox(
                              height: 30,
                              child: Tab(child: Text("Register")),
                            ),
                          ],
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey[600],
                          indicator: RectangularIndicator(
                            bottomLeftRadius: 5,
                            bottomRightRadius: 5,
                            topLeftRadius: 5,
                            topRightRadius: 5,
                            color: activeTabColor,
                          ),
                          onTap: (id) {
                            setState(() {
                              if (id == 0) {
                                isLogin = true;
                              } else {
                                isLogin = false;
                              }
                            });
                          },
                        ))),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: TabBarView(
                    children: [
                      n.Column([
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.contain,
                            height: 64,
                          ),
                        ),
                        Txt('Login', style: titleStyle),
                        Txt(
                          '',
                          style: inputFieldStyle(_isLoginUsernameFieldActive,
                              inputFieldActiveStyle)
                            ..editable(
                              autoFocus: true,
                              placeholder: 'Enter Username',
                              onChange: (String? value) {
                                setState(() => userNameLogin =
                                    value != null ? value! : '');
                              },
                              onFocusChange: (hasFocus) {
                                if (hasFocus != _isLoginUsernameFieldActive)
                                  setState(() => _isLoginUsernameFieldActive =
                                      hasFocus ?? _isLoginUsernameFieldActive);
                              },
                            ),
                        ),
                        Txt(
                          '',
                          style: inputFieldStyle(_isLoginPasswordFieldActive,
                              inputFieldActiveStyle)
                            ..editable(
                              placeholder: 'Enter Password',
                              obscureText: true,
                              onChange: (String? value) {
                                setState(() => passwordLogin =
                                    value != null ? value! : '');
                              },
                              onFocusChange: (hasFocus) {
                                if (hasFocus != _isLoginPasswordFieldActive)
                                  setState(() => _isLoginPasswordFieldActive =
                                      hasFocus ?? _isLoginPasswordFieldActive);
                              },
                            ),
                        ),
                        Txt("Forgot password?",
                            style: TxtStyle()..margin(top: 5)),
                        Txt('Submit',
                            style: submitButtonStyle,
                            gesture: Gestures()
                              ..onTap(() => onAuthButtonPressed())),
                        n.Row([
                          Container(
                            margin: const EdgeInsets.only(right: 10, top: 10),
                            child: GFBorder(
                              color: const Color(0xFF19CA4B),
                              dashedLine: const [2, 1],
                              type: GFBorderType.rect,
                              child: Image.asset(
                                './assets/google.png',
                                width: 30,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: GFBorder(
                              color: const Color(0xFF19CA4B),
                              dashedLine: const [2, 1],
                              type: GFBorderType.rect,
                              child: Image.asset(
                                './assets/facebook.png',
                                width: 30,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ])
                          ..mainCenter
                          ..crossCenter
                      ]),
                      n.Column([
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.contain,
                            height: 64,
                          ),
                        ),
                        Txt('Register', style: titleStyle),
                        Txt(
                          '',
                          style: inputFieldStyle(_isRegisterUsernameFieldActive,
                              inputFieldActiveStyle)
                            ..editable(
                              autoFocus: true,
                              placeholder: 'Enter Username',
                              onChange: (String? value) {
                                setState(() => userNameRegister =
                                    value != null ? value! : '');
                              },
                              onFocusChange: (hasFocus) {
                                if (hasFocus != _isRegisterUsernameFieldActive)
                                  setState(() =>
                                      _isRegisterUsernameFieldActive =
                                          hasFocus ??
                                              _isRegisterUsernameFieldActive);
                              },
                            ),
                        ),
                        Txt(
                          '',
                          style: inputFieldStyle(_isRegisterPasswordFieldActive,
                              inputFieldActiveStyle)
                            ..editable(
                              placeholder: 'Enter Password',
                              obscureText: true,
                              onChange: (String? value) {
                                setState(() => passwordRegister =
                                    value != null ? value! : '');
                              },
                              onFocusChange: (hasFocus) {
                                if (hasFocus != _isRegisterPasswordFieldActive)
                                  setState(() =>
                                      _isRegisterPasswordFieldActive =
                                          hasFocus ??
                                              _isRegisterPasswordFieldActive);
                              },
                            ),
                        ),
                        Txt(
                          '',
                          style: inputFieldStyle(
                              _isRegisterPasswordConfirmFieldActive,
                              inputFieldActiveStyle)
                            ..editable(
                              placeholder: 'Confirm Password',
                              obscureText: true,
                              onChange: (String? value) {
                                setState(() => passwordConfirmRegister =
                                    value != null ? value! : '');
                              },
                              onFocusChange: (hasFocus) {
                                if (hasFocus !=
                                    _isRegisterPasswordConfirmFieldActive)
                                  setState(() =>
                                      _isRegisterPasswordConfirmFieldActive =
                                          hasFocus ??
                                              _isRegisterPasswordConfirmFieldActive);
                              },
                            ),
                        ),
                        Txt(
                          '',
                          style: inputFieldStyle(
                              _isRegisterReferalIdFieldActive,
                              inputFieldActiveStyle)
                            ..editable(
                              keyboardType: TextInputType.number,
                              placeholder: 'Referal Id',
                              onChange: (String? value) {
                                setState(() => referalIdRegister =
                                    value != null ? value! : '');
                              },
                              onFocusChange: (hasFocus) {
                                if (hasFocus != _isRegisterReferalIdFieldActive)
                                  setState(() =>
                                      _isRegisterReferalIdFieldActive =
                                          hasFocus ??
                                              _isRegisterReferalIdFieldActive);
                              },
                            ),
                        ),
                        Txt('Submit',
                            style: submitButtonStyle,
                            gesture: Gestures()
                              ..onTap(() => onAuthButtonPressed())),
                        n.Row([
                          Container(
                            margin: const EdgeInsets.only(right: 10, top: 10),
                            child: GFBorder(
                              color: const Color(0xFF19CA4B),
                              dashedLine: const [2, 1],
                              type: GFBorderType.rect,
                              child: Image.asset(
                                './assets/google.png',
                                width: 30,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: GFBorder(
                              color: const Color(0xFF19CA4B),
                              dashedLine: const [2, 1],
                              type: GFBorderType.rect,
                              child: Image.asset(
                                './assets/facebook.png',
                                width: 30,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ])
                          ..mainCenter
                          ..crossCenter
                      ]),
                    ],
                  ),
                ))
              ],
            )));
  }
}
