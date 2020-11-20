import 'dart:convert';

import 'package:flutter/services.dart';

class Vars {
  static Vars _instance = null;

  Map<String, dynamic> cardOptions;

  static Vars get instance {
    if (_instance == null) _instance = Vars();
    return _instance;
  }

  Future init() async {
    cardOptions = jsonDecode(
        await rootBundle.loadString('assets/vars/card_options.json'));
    // print(json);
  }
}
