import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hearthstonecatalog/models/CardModel.dart';
import 'package:http/http.dart';

class Api {
  static Api _instance = null;
  String urlImage512 =
      "https://art.hearthstonejson.com/v1/render/latest/enUS/512x/";
  String urlImage256 =
      "https://art.hearthstonejson.com/v1/render/latest/enUS/256x/";

  String urlApi =
      "https://api.hearthstonejson.com/v1/latest/enUS/cards.collectible.json";

  String _urlSound =
      "https://media-hearth.cursecdn.com/audio/card-sounds/sound/VO_";

  static Api get instance {
    if (_instance == null) _instance = Api();
    return _instance;
  }

  String getSound(CardModel card) {
    return _urlSound + card.id + "_Play_01.ogg";
  }

  Future<String> getCards() async {
    // return await
    Response resp = await get(urlApi);
    if (resp.statusCode != 200) throw Exception("Error getting cards.");
    return resp.body;
    return await rootBundle.loadString("assets/hearthstone_cards.json");
  }
}
