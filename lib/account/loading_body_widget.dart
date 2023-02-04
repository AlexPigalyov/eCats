import 'package:flutter/cupertino.dart';

class LoadingBodyWidget extends Center {
  LoadingBodyWidget({super.key, rememberMe = false})
      : super(
            child: Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 64,
          ),
        ));
}
