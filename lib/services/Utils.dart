import 'dart:math';

import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hearthstonecatalog/main.dart';
import 'package:http/http.dart';

class Utils {
  static Utils _instance = null;
  VoidCallback action;
  Timer _timer;

  static Utils get instance {
    if (_instance == null) _instance = Utils();
    return _instance;
  }

  removeFocus(BuildContext context) {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      FocusScopeNode currentFocus = FocusScope.of(context);
      // if (!currentFocus.hasPrimaryFocus) {
      //   currentFocus.unfocus();
      // }
      FocusScope.of(context).requestFocus(FocusNode());
    } catch (e) {
      print(e);
    }
  }

  double angleToRadian([double angle = 0]) {
    return angle * pi / 180;
  }

  Future<bool> checkUrlWorks(@required String url) async {
    Response resp = await head(url);

    if (resp.statusCode == 200) return true;
    return false;
  }

  updateAppState(BuildContext context) {
    try {
      MyAppState myAppState = context.findRootAncestorStateOfType<MyAppState>();
      myAppState.setState(() {});
    } catch (e) {}
  }

  // Debounce
  run(VoidCallback action, int milliseconds) {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
