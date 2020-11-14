import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hearthstonecatalog/models/CardModel.dart';
import 'package:hearthstonecatalog/services/Api.dart';
import 'package:hearthstonecatalog/services/Status.dart';

class CardsProv extends ChangeNotifier {
  List<CardModel> _cards = [];
  Status cardsStatus = Status.loading;

  List<CardModel> get cards {
    return _cards;
  }

  Future loadCards() async {
    String tmpCards = await Api.instance.getCards();
    _cards = (jsonDecode(tmpCards) as List).map((e) {
      return CardModel.fromJson(e);
    }).toList();
    // String tmpCards = await Api.instance.getCards();
    // _cards = (jsonDecode(tmpCards) as List).map((e) {
    //   var tmpCardModel = CardModel.fromJson(e);
    //   return tmpCardModel;
    // }).where((e) {
    //   if (e.cardTypeId == 3) return false;
    //   return true;
    // }).toList();
    notifyListeners();
  }

  List<CardModel> getFilterdCards({String search: ""}) {
    search = search.toLowerCase().trim();
    // print('getFilterdCards');
    var tmpCards = _cards.where((e) {
      String tmpName = e.name.toLowerCase().trim();
      String tmpTxt = e?.text?.toLowerCase()?.trim() ?? "";
      if (tmpName.indexOf(search) > -1 || tmpTxt.indexOf(search) > -1)
        return true;
      return false;
    }).toList();

    // notifyListeners();
    return tmpCards;
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
    print("---------- CardsProv notifyListeners ----------");
  }
}
