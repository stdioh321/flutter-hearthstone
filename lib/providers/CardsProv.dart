import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hearthstonecatalog/models/CardModel.dart';
import 'package:hearthstonecatalog/models/FilterModel.dart';
import 'package:hearthstonecatalog/services/Api.dart';
import 'package:hearthstonecatalog/services/Status.dart';

class CardsProv extends ChangeNotifier {
  List<CardModel> _cardsAll = [];
  List<CardModel> _cards = [];
  Status cardsStatus = Status.loading;
  FilterModel filters = FilterModel();

  CardsProv() {
    // print(filters.cardClasses);
  }
  List<CardModel> get cards {
    return _cards;
  }

  List<CardModel> get cardsAll {
    return _cardsAll;
  }

  Future loadCards({String lang: "enUS"}) async {
    String tmpCards = await Api.instance.getCards(lang: lang);
    _cardsAll = (jsonDecode(tmpCards) as List).map((e) {
      return CardModel.fromJson(e);
    }).toList();
    _cardsAll.sort((a, b) {
      String tmpNameA = a.name.toLowerCase().trim();
      String tmpNameB = b.name.toLowerCase().trim();
      return tmpNameA.compareTo(tmpNameB);
    });
    _cards = [..._cardsAll];
    notifyListeners();
  }

  void execFilterCards({String search: "", FilterModel filters}) {
    print('execFilterCards');
    search = search.toLowerCase().trim();
    var tmpCards = [..._cardsAll];
    if (filters != null) {
      if (filters.cardClasses.containsValue(true))
        tmpCards = tmpCards.where((e) {
          if (filters.cardClasses[e.cardClass] == true) return true;
          return false;
        }).toList();
      if (filters.rarity.containsValue(true))
        tmpCards = tmpCards.where((e) {
          if (filters.rarity[e.rarity] == true) return true;
          return false;
        }).toList();
      if (filters.cardType.containsValue(true))
        tmpCards = tmpCards.where((e) {
          if (filters.cardType[e.type] == true) return true;
          return false;
        }).toList();
      if (filters.cost.containsValue(true))
        tmpCards = tmpCards.where((e) {
          if (filters.cost[e.cost.toString()] == true) return true;
          return false;
        }).toList();
    }
    // print(filters.cardType);
    tmpCards = tmpCards.where((e) {
      String tmpName = e.name.toLowerCase().trim();
      String tmpTxt = e?.text?.toLowerCase()?.trim() ?? "";
      if (tmpName.indexOf(search) > -1 || tmpTxt.indexOf(search) > -1)
        return true;
      return false;
    }).toList();
    _cards = tmpCards;
    // print(_cards.length);
    notifyListeners();
    // return tmpCards;
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
