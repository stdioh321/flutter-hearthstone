import 'package:hearthstonecatalog/services/Vars.dart';

class FilterModel {
  String search;
  Map<String, bool> cardClasses = {};
  Map<String, bool> rarity = {};
  Map<String, bool> cardType = {};
  Map<String, bool> cost = {};
  FilterModel() {
    reset();
  }

  reset({bool clearSearch: false}) {
    if (clearSearch) search = "";
    cardClasses = {};
    rarity = {};
    cardType = {};
    cost = {};

    (Vars.instance.cardOptions['cardClasses'] as List).forEach((e) {
      cardClasses.putIfAbsent(e, () => false);
    });
    (Vars.instance.cardOptions['rarity'] as List).forEach((e) {
      rarity.putIfAbsent(e, () => false);
    });
    (Vars.instance.cardOptions['cardType'] as List).forEach((e) {
      cardType.putIfAbsent(e, () => false);
    });
    List.generate(13, (index) {
      cost.putIfAbsent('${index}', () => false);
    });
  }
}
