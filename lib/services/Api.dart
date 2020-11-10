import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hearthstonecatalog/models/CardModel.dart';

class Api {
  static Api _instance = null;

  static Api get instance {
    if (_instance == null) _instance = Api();
    return _instance;
  }

  Future<List<CardModel>> getCards() async {
    try {
      String strCards =
          await rootBundle.loadString("assets/hearthstone_cards.json");

      List<CardModel> _cards = (jsonDecode(strCards) as List).map((e) {
        var tmpCard = CardModel.fromJson(e);
        // print(tmpCard.name.deDE);
        return tmpCard;
      }).toList();
      return _cards;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
