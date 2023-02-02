
import 'package:ecats/Extensions/HexColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileBodyWidget extends StatefulWidget {
  const ProfileBodyWidget({super.key});

  @override
  State<ProfileBodyWidget> createState() => _ProfileBodyWidgetState();
}

class _ProfileBodyWidgetState extends State<ProfileBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
            color: HexColor.fromHex('#f3f3f7'),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Expanded(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            const Icon(
                              Icons.account_circle_outlined,
                              size: 72,
                            ),
                            Text(
                              "test@gmail.com",
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w800,
                                fontSize: 15.75,
                                color: HexColor.fromHex('#6C757D'),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(margin: const EdgeInsets.only(top: 60)),
                                        Text(
                                          "Refferal link: ",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#6C757D'),
                                          ),
                                        ),
                                        Text(
                                          "https://ecats.online/Register?refid=3 ",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#98a6ad'),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              Icons.copy,
                                              size: 12
                                          ),
                                          onPressed: () {},
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
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
                                        Text(
                                          "Undefined",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#98a6ad'),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(margin: const EdgeInsets.only(top: 20)),
                                        Text(
                                          "Email: ",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#6C757D'),
                                          ),
                                        ),
                                        Text(
                                          "test@gmail.com",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#98a6ad'),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(margin: const EdgeInsets.only(top: 20)),
                                        Text(
                                          "Location: ",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#6C757D'),
                                          ),
                                        ),
                                        Text(
                                          "Not selected",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: HexColor.fromHex('#98a6ad'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(margin: const EdgeInsets.only(top: 10)),
                                  ],
                                )
                            ),
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
                                  const Icon(
                                      Icons.work,
                                      size: 12
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "INCOMES",
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
                                  const Icon(
                                      Icons.work,
                                      size: 12
                                  ),
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
                              onPressed: () {},
                            ),
                            MaterialButton(
                              child: Row(
                                children: [
                                  const Icon(
                                      Icons.work,
                                      size: 12
                                  ),
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
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 15),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.account_circle,
                                      size: 10,
                                    ),
                                    Container(margin: const EdgeInsets.only(left: 5)),
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
                                  margin: const EdgeInsets.only(top: 30, bottom: 5),
                                  alignment: FractionalOffset.centerLeft,
                                  child: Text(
                                    "Username",
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#6C757D'),
                                    ),
                                  )
                                ),
                                TextField(
                                  style: TextStyle(
                                    fontSize: 12.6,
                                    color: HexColor.fromHex('#5c6369'),
                                    decorationThickness: 0
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter Username',
                                    hintStyle: const TextStyle(
                                      fontSize: 12.6,
                                      color: Colors.grey,
                                      decorationThickness: 0
                                    ),
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
                                    margin: const EdgeInsets.only(top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "FullName",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )
                                ),
                                TextField(
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter Full Name',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0
                                    ),
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
                                    margin: const EdgeInsets.only(top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Bio",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )
                                ),
                                TextField(
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
                                        decorationThickness: 0
                                    ),
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
                                        Container(margin: const EdgeInsets.only(left: 5)),
                                        Text(
                                          "SOCIAL",
                                          style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10.5,
                                            color: HexColor.fromHex('#6C757D'),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ),
                                Container(
                                    margin: const EdgeInsets.only(top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Facebook",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )
                                ),
                                TextField(
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(left: 15),
                                    prefixIconConstraints: const BoxConstraints(
                                      maxHeight: double.maxFinite,
                                      maxWidth: double.maxFinite,
                                      minHeight: 32,
                                      minWidth: 32
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.facebook,
                                      size: 20,
                                    ),
                                    hintText: 'Url',
                                    hintStyle: const TextStyle(
                                      fontSize: 12.6,
                                      color: Colors.grey,
                                      decorationThickness: 0
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
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
                                    margin: const EdgeInsets.only(top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Twitter",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )
                                ),
                                TextField(
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0
                                    ),
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
                                    margin: const EdgeInsets.only(top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Instagram",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )
                                ),
                                TextField(
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Url',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0
                                    ),
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
                                    margin: const EdgeInsets.only(top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Linkdin",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )
                                ),
                                TextField(
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Url',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0
                                    ),
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
                                    margin: const EdgeInsets.only(top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Skype",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )
                                ),
                                TextField(
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0
                                    ),
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
                                    margin: const EdgeInsets.only(top: 20, bottom: 5),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Github",
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.6,
                                        color: HexColor.fromHex('#6C757D'),
                                      ),
                                    )
                                ),
                                TextField(
                                  style: TextStyle(
                                      fontSize: 12.6,
                                      color: HexColor.fromHex('#5c6369'),
                                      decorationThickness: 0
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    hintStyle: const TextStyle(
                                        fontSize: 12.6,
                                        color: Colors.grey,
                                        decorationThickness: 0
                                    ),
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
                                Container(margin: const EdgeInsets.only(bottom: 20)),
                              ],
                            ),
                          )
                      )
                    ],
                  )
              ),
            )
        ),
      )
    );
  }

}