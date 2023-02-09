import 'dart:convert';

import 'package:ecats/assets/constants.dart' as Constants;
import 'package:ecats/extensions/hex_color.dart';
import 'package:ecats/models/enums/app_bar_enum.dart';
import 'package:ecats/models/enums/page_enum.dart';
import 'package:ecats/models/requests/profile_request_model.dart';
import 'package:ecats/services/http_service.dart';
import 'package:ecats/widgets/shared/loading_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileBodyWidget extends StatefulWidget {
  final void Function(PageEnum, AppBarEnum, dynamic) screenCallback;

  const ProfileBodyWidget({super.key, required this.screenCallback});

  @override
  State<ProfileBodyWidget> createState() => _ProfileBodyWidgetState();
}

class _ProfileBodyWidgetState extends State<ProfileBodyWidget> {
  final _httpService = HttpService();
  bool isLoading = true;
  late ProfileRequestModel model;

  late final TextEditingController usernameTextEditingController;
  late final TextEditingController fullNameTextEditingController;
  late final TextEditingController aboutMeTextEditingController;
  late final TextEditingController faceBookTextEditingController;
  late final TextEditingController twitterTextEditingController;
  late final TextEditingController instagramTextEditingController;
  late final TextEditingController linkedinTextEditingController;
  late final TextEditingController skypeTextEditingController;
  late final TextEditingController githubTextEditingController;

  @override
  void initState() {
    super.initState();

    _updateData().then((x) {
      setState(() {
        usernameTextEditingController =
            TextEditingController(text: model.username);
        fullNameTextEditingController =
            TextEditingController(text: model.userInfo.fullName);
        aboutMeTextEditingController =
            TextEditingController(text: model.userInfo.aboutMe);
        faceBookTextEditingController =
            TextEditingController(text: model.userInfo.facebookLink);
        twitterTextEditingController =
            TextEditingController(text: model.userInfo.twitterLink);
        instagramTextEditingController =
            TextEditingController(text: model.userInfo.instagramLink);
        linkedinTextEditingController =
            TextEditingController(text: model.userInfo.linkedinLink);
        skypeTextEditingController =
            TextEditingController(text: model.userInfo.skypeLink);
        githubTextEditingController =
            TextEditingController(text: model.userInfo.githubLink);
      });
    });
  }

  void updateProfileData() async {
    setState(() => isLoading = true);
    var uri = Uri.https(
        Constants.SERVER_URL, Constants.ServerApiEndpoints.PROFILE_UPDATE);

    model.username = usernameTextEditingController.text;
    model.userInfo.fullName = fullNameTextEditingController.text;
    model.userInfo.aboutMe = aboutMeTextEditingController.text;
    model.userInfo.facebookLink = faceBookTextEditingController.text;
    model.userInfo.twitterLink = twitterTextEditingController.text;
    model.userInfo.instagramLink = instagramTextEditingController.text;
    model.userInfo.linkedinLink = linkedinTextEditingController.text;
    model.userInfo.skypeLink = skypeTextEditingController.text;
    model.userInfo.githubLink = githubTextEditingController.text;
    model.userInfo.profilePhotoPath = '';
    model.userInfo.location = '';
    model.userInfo.refferalId = '';
    model.phoneNumber = '';

    var response = await _httpService.post(uri, model);

    await _updateData();
    //TODO: else if error
  }

  Future _updateData() async {
    setState(() => isLoading = true);

    var uri =
        Uri.https(Constants.SERVER_URL, Constants.ServerApiEndpoints.PROFILE);
    var response = await _httpService.get(uri);
    var value = await response.stream.bytesToString();

    model = ProfileRequestModel.fromJson(jsonDecode(value));

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingBodyWidget()
        : Center(
            child: SingleChildScrollView(
            child: Container(
                color: HexColor.fromHex('#f3f3f7'),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(margin: const EdgeInsets.only(top: 10)),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 0)),
                                        Text(
                                          "Username: ",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#6C757D'),
                                          ),
                                        ),
                                        Flexible(
                                            child: Text(
                                          model.username,
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#98a6ad'),
                                          ),
                                        ))
                                      ],
                                    ),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Email: ",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#6C757D'),
                                          ),
                                        ),
                                        Flexible(
                                            child: Text(
                                          model.email,
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#98a6ad'),
                                          ),
                                        ))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Your ID: ",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#6C757D'),
                                          ),
                                        ),
                                        Flexible(
                                            child: Text(
                                          model.userNumber,
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#98a6ad'),
                                          ),
                                        ))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ref: ",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#6C757D'),
                                          ),
                                        ),
                                        Flexible(
                                            child: Text(
                                          "https://ecats.online/Register?refid=${model.userNumber}",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#98a6ad'),
                                          ),
                                        )),
                                        IconButton(
                                          icon:
                                              const Icon(Icons.copy, size: 12),
                                          onPressed: () async {
                                            await Clipboard.setData(ClipboardData(
                                                text:
                                                    'https://ecats.online/Register?refid=${model.userNumber}'));
                                          },
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Full Name: ",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#6C757D'),
                                          ),
                                        ),
                                        Flexible(
                                            child: Text(
                                          model.userInfo.fullName ??
                                              "Undefined",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#98a6ad'),
                                          ),
                                        )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 20)),
                                        Text(
                                          "Location: ",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#6C757D'),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            model.userInfo.location ??
                                                "Not selected",
                                            style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color:
                                                  HexColor.fromHex('#98a6ad'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(top: 10)),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        color: Colors.white,
                        child: Column(
                          children: [
                            MaterialButton(
                              child: Row(
                                children: [
                                  const Icon(Icons.work, size: 12),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "OPEN ORDERS",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.5,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                widget.screenCallback(PageEnum.OpenOrders,
                                    AppBarEnum.Authorized, null);
                              },
                            ),
                            MaterialButton(
                              child: Row(
                                children: [
                                  const Icon(Icons.work, size: 12),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "CLOSED ORDERS",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.5,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                widget.screenCallback(PageEnum.ClosedOrders,
                                    AppBarEnum.Authorized, null);
                              },
                            ),
                            MaterialButton(
                              child: Row(
                                children: [
                                  const Icon(Icons.work, size: 12),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "WALLETS",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.5,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                widget.screenCallback(PageEnum.Wallets,
                                    AppBarEnum.Authorized, null);
                              },
                            ),
                            MaterialButton(
                              child: Row(
                                children: [
                                  const Icon(Icons.work, size: 12),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "INCOMES TRANSACTIONS",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.5,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                widget.screenCallback(
                                    PageEnum.IncomeTransactions,
                                    AppBarEnum.Authorized,
                                    null);
                              },
                            ),
                            MaterialButton(
                              child: Row(
                                children: [
                                  const Icon(Icons.work, size: 12),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "INCOMES WALLETS",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.5,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                widget.screenCallback(PageEnum.IncomeWallets,
                                    AppBarEnum.Authorized, null);
                              },
                            ),
                            MaterialButton(
                              child: Row(
                                children: [
                                  const Icon(Icons.work, size: 12),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "WITHDRAWS",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.5,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                widget.screenCallback(PageEnum.Wallets,
                                    AppBarEnum.Authorized, null);
                              },
                            ),
                            MaterialButton(
                              child: Row(
                                children: [
                                  const Icon(Icons.work, size: 12),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "TRANSFERS",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.5,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {},
                            ),
                            MaterialButton(
                              child: Row(
                                children: [
                                  const Icon(Icons.work, size: 12),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "REFERALS",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.5,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                widget.screenCallback(PageEnum.Refferals,
                                    AppBarEnum.Authorized, null);
                              },
                            ),
                            MaterialButton(
                              child: Row(
                                children: [
                                  const Icon(Icons.work, size: 12),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "EVENTS",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.5,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                widget.screenCallback(PageEnum.Events,
                                    AppBarEnum.Authorized, null);
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 15),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.account_circle,
                                      size: 10,
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(left: 5)),
                                    Text(
                                      "PERSONAL INFO",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.5,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Username",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )),
                                TextFormField(
                                  controller: usernameTextEditingController,
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0),
                                  decoration: InputDecoration(
                                    hintText: 'Enter Username',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(9),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#bdc0c4'),
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#dee2e6'),
                                          width: 1.0),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                  cursorWidth: 0.5,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "FullName",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )),
                                TextFormField(
                                  controller: fullNameTextEditingController,
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0),
                                  decoration: InputDecoration(
                                    hintText: 'Enter Full Name',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(9),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#bdc0c4'),
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#dee2e6'),
                                          width: 1.0),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                  cursorWidth: 0.5,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Bio",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )),
                                TextFormField(
                                  controller: aboutMeTextEditingController,
                                  maxLines: 7,
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0),
                                  decoration: InputDecoration(
                                    hintText: 'Write something...',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(9),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#bdc0c4'),
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#dee2e6'),
                                          width: 1.0),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                  cursorWidth: 0.5,
                                ),
                                /*
                                Container(
                                    margin: const EdgeInsets.only(top: 30),
                                    color: HexColor.fromHex('#f5f4f9'),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.public,
                                            size: 12,
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 5)),
                                          Text(
                                            "SOCIAL",
                                            style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10.5,
                                              color:
                                                  HexColor.fromHex('#6C757D'),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Facebook",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )),
                                TextFormField(
                                  controller: faceBookTextEditingController,
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 15),
                                    prefixIconConstraints: const BoxConstraints(
                                        maxHeight: double.maxFinite,
                                        maxWidth: double.maxFinite,
                                        minHeight: 32,
                                        minWidth: 32),
                                    prefixIcon: const Icon(
                                      Icons.facebook,
                                      size: 20,
                                    ),
                                    hintText: 'Url',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#bdc0c4'),
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#dee2e6'),
                                          width: 1.0),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                  cursorWidth: 0.5,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Twitter",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )),
                                TextFormField(
                                  controller: twitterTextEditingController,
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0),
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(9),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#bdc0c4'),
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#dee2e6'),
                                          width: 1.0),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                  cursorWidth: 0.5,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Instagram",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )),
                                TextFormField(
                                  controller: instagramTextEditingController,
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0),
                                  decoration: InputDecoration(
                                    hintText: 'Url',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(9),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#bdc0c4'),
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#dee2e6'),
                                          width: 1.0),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                  cursorWidth: 0.5,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Linkedin",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )),
                                TextFormField(
                                  controller: linkedinTextEditingController,
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0),
                                  decoration: InputDecoration(
                                    hintText: 'Url',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(9),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#bdc0c4'),
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#dee2e6'),
                                          width: 1.0),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                  cursorWidth: 0.5,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Skype",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )),
                                TextFormField(
                                  controller: skypeTextEditingController,
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0),
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(9),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#bdc0c4'),
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#dee2e6'),
                                          width: 1.0),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                  cursorWidth: 0.5,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Github",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )),
                                TextFormField(
                                  controller: githubTextEditingController,
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0),
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(9),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#bdc0c4'),
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor.fromHex('#dee2e6'),
                                          width: 1.0),
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                  cursorWidth: 0.5,
                                ),
                                */

                                Container(
                                    margin: const EdgeInsets.only(bottom: 20)),
                                Container(
                                  alignment: FractionalOffset.centerLeft,
                                  child: MaterialButton(
                                    color: HexColor.fromHex('#1b6ec2'),
                                    height: 35,
                                    onPressed: updateProfileData,
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Nunito',
                                        fontSize: 12.6,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(bottom: 20)),
                              ],
                            ),
                          ))
                    ],
                  ),
                )),
          ));
  }
}
