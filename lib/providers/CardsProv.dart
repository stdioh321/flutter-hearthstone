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

  Future loadCards({String lang: "enUS"}) async {
    String tmpCards = await Api.instance.getCards(lang: lang);
    _cards = (jsonDecode(tmpCards) as List).map((e) {
      return CardModel.fromJson(e);
    }).toList();
    _cards.sort((a, b) {
      String tmpNameA = a.name.toLowerCase().trim();
      String tmpNameB = b.name.toLowerCase().trim();
      return tmpNameA.compareTo(tmpNameB);
    });
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
    // print('getFilterdCards');
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

  // String getImage(@required CardModel card, {bool img512: false}) {
  //   String img =
  //       img512 == true ? Api.instance.urlImage512 : Api.instance.urlImage256;
  //   return "${img}${card.id}.png";
  // }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
    print("---------- CardsProv notifyListeners ----------");
  }
}
