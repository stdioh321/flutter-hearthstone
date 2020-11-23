class CardModel {
  String _artist;
  int _attack;
  int _battlegroundsPremiumDbfId;
  String _cardClass;
  bool _collectible;
  int _cost;
  int _dbfId;
  String _flavor;
  int _health;
  String _howToEarnGolden;
  String _id;
  List<String> _mechanics;
  List<String> _referencedTags;
  String _name;
  String _race;
  String _rarity;
  String _set;
  int _techLevel;
  String _text;
  String _type;

  CardModel(
      {String artist,
      int attack,
      int battlegroundsPremiumDbfId,
      String cardClass,
      bool collectible,
      int cost,
      int dbfId,
      String flavor,
      int health,
      String howToEarnGolden,
      String id,
      List<String> mechanics,
      List<String> referencedTags,
      String name,
      String race,
      String rarity,
      String set,
      int techLevel,
      String text,
      String type}) {
    this._artist = artist;
    this._attack = attack;
    this._battlegroundsPremiumDbfId = battlegroundsPremiumDbfId;
    this._cardClass = cardClass;
    this._collectible = collectible;
    this._cost = cost;
    this._dbfId = dbfId;
    this._flavor = flavor;
    this._health = health;
    this._howToEarnGolden = howToEarnGolden;
    this._id = id;
    this._mechanics = mechanics;
    this._referencedTags = referencedTags;
    this._name = name;
    this._race = race;
    this._rarity = rarity;
    this._set = set;
    this._techLevel = techLevel;
    this._text = text;
    this._type = type;
  }

  String get artist => _artist;
  set artist(String artist) => _artist = artist;
  int get attack => _attack;
  set attack(int attack) => _attack = attack;
  int get battlegroundsPremiumDbfId => _battlegroundsPremiumDbfId;
  set battlegroundsPremiumDbfId(int battlegroundsPremiumDbfId) =>
      _battlegroundsPremiumDbfId = battlegroundsPremiumDbfId;
  String get cardClass => _cardClass;
  set cardClass(String cardClass) => _cardClass = cardClass;
  bool get collectible => _collectible;
  set collectible(bool collectible) => _collectible = collectible;
  int get cost => _cost;
  set cost(int cost) => _cost = cost;
  int get dbfId => _dbfId;
  set dbfId(int dbfId) => _dbfId = dbfId;
  String get flavor => _flavor;
  set flavor(String flavor) => _flavor = flavor;
  int get health => _health;
  set health(int health) => _health = health;
  String get howToEarnGolden => _howToEarnGolden;
  set howToEarnGolden(String howToEarnGolden) =>
      _howToEarnGolden = howToEarnGolden;
  String get id => _id;
  set id(String id) => _id = id;
  List<String> get mechanics => _mechanics;
  set mechanics(List<String> mechanics) => _mechanics = mechanics;
  List<String> get referencedTags => _referencedTags;
  set referencedTags(List<String> referencedTags) =>
      _referencedTags = referencedTags;
  String get name => _name;
  set name(String name) => _name = name;
  String get race => _race;
  set race(String race) => _race = race;
  String get rarity => _rarity;
  set rarity(String rarity) => _rarity = rarity;
  String get set => _set;
  set set(String set) => _set = set;
  int get techLevel => _techLevel;
  set techLevel(int techLevel) => _techLevel = techLevel;
  String get text => _text;
  set text(String text) => _text = text;
  String get type => _type;
  set type(String type) => _type = type;

  CardModel.fromJson(Map<String, dynamic> json) {
    _artist = json['artist'];
    _attack = json['attack'];
    _battlegroundsPremiumDbfId = json['battlegroundsPremiumDbfId'];
    _cardClass = json['cardClass'];
    _collectible = json['collectible'];
    _cost = json['cost'];
    _dbfId = json['dbfId'];
    _flavor = json['flavor'];
    _health = json['health'];
    _howToEarnGolden = json['howToEarnGolden'];
    _id = json['id'];
    _mechanics =
        json['mechanics'] != null ? json['mechanics'].cast<String>() : null;
    _referencedTags = json['referencedTags'] != null
        ? json['referencedTags'].cast<String>()
        : null;
    _name = json['name'];
    _race = json['race'];
    _rarity = json['rarity'];
    _set = json['set'];
    _techLevel = json['techLevel'];
    _text = json['text'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['artist'] = this._artist;
    data['attack'] = this._attack;
    data['battlegroundsPremiumDbfId'] = this._battlegroundsPremiumDbfId;
    data['cardClass'] = this._cardClass;
    data['collectible'] = this._collectible;
    data['cost'] = this._cost;
    data['dbfId'] = this._dbfId;
    data['flavor'] = this._flavor;
    data['health'] = this._health;
    data['howToEarnGolden'] = this._howToEarnGolden;
    data['id'] = this._id;
    data['mechanics'] = this._mechanics;
    data['referencedTags'] = this._referencedTags;
    data['name'] = this._name;
    data['race'] = this._race;
    data['rarity'] = this._rarity;
    data['set'] = this._set;
    data['techLevel'] = this._techLevel;
    data['text'] = this._text;
    data['type'] = this._type;
    return data;
  }
}
