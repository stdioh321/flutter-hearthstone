import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hearthstonecatalog/models/CardModel.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Prefs _instance = null;
  SharedPreferences prefs;

  static Prefs get instance {
    if (_instance == null) _instance = Prefs();
    return _instance;
  }

  String getLang() {
    return prefs.getString("lang") ?? "enUS";
  }

  bool getBrightness() {
    return prefs.getBool("isDark") == true ? true : false;
  }
}
