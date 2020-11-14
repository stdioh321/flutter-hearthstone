class CardModel {
  String _id;
  int _dbfId;
  String _name;
  String _text;
  String _flavor;
  String _artist;
  int _attack;
  String _cardClass;
  bool _collectible;
  int _cost;
  bool _elite;
  String _faction;
  int _health;
  List<String> _mechanics;
  String _rarity;
  String _set;
  String _type;

  CardModel(
      {String id,
      int dbfId,
      String name,
      String text,
      String flavor,
      String artist,
      int attack,
      String cardClass,
      bool collectible,
      int cost,
      bool elite,
      String faction,
      int health,
      List<String> mechanics,
      String rarity,
      String set,
      String type}) {
    this._id = id;
    this._dbfId = dbfId;
    this._name = name;
    this._text = text;
    this._flavor = flavor;
    this._artist = artist;
    this._attack = attack;
    this._cardClass = cardClass;
    this._collectible = collectible;
    this._cost = cost;
    this._elite = elite;
    this._faction = faction;
    this._health = health;
    this._mechanics = mechanics;
    this._rarity = rarity;
    this._set = set;
    this._type = type;
  }

  String get id => _id;
  set id(String id) => _id = id;
  int get dbfId => _dbfId;
  set dbfId(int dbfId) => _dbfId = dbfId;
  String get name => _name;
  set name(String name) => _name = name;
  String get text => _text;
  set text(String text) => _text = text;
  String get flavor => _flavor;
  set flavor(String flavor) => _flavor = flavor;
  String get artist => _artist;
  set artist(String artist) => _artist = artist;
  int get attack => _attack;
  set attack(int attack) => _attack = attack;
  String get cardClass => _cardClass;
  set cardClass(String cardClass) => _cardClass = cardClass;
  bool get collectible => _collectible;
  set collectible(bool collectible) => _collectible = collectible;
  int get cost => _cost;
  set cost(int cost) => _cost = cost;
  bool get elite => _elite;
  set elite(bool elite) => _elite = elite;
  String get faction => _faction;
  set faction(String faction) => _faction = faction;
  int get health => _health;
  set health(int health) => _health = health;
  List<String> get mechanics => _mechanics;
  set mechanics(List<String> mechanics) => _mechanics = mechanics;
  String get rarity => _rarity;
  set rarity(String rarity) => _rarity = rarity;
  String get set => _set;
  set set(String set) => _set = set;
  String get type => _type;
  set type(String type) => _type = type;

  CardModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _dbfId = json['dbfId'];
    _name = json['name'];
    _text = json['text'];
    _flavor = json['flavor'];
    _artist = json['artist'];
    _attack = json['attack'];
    _cardClass = json['cardClass'];
    _collectible = json['collectible'];
    _cost = json['cost'];
    _elite = json['elite'];
    _faction = json['faction'];
    _health = json['health'];
    _mechanics = json['mechanics']?.cast<String>() ?? [];
    _rarity = json['rarity'];
    _set = json['set'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['dbfId'] = this._dbfId;
    data['name'] = this._name;
    data['text'] = this._text;
    data['flavor'] = this._flavor;
    data['artist'] = this._artist;
    data['attack'] = this._attack;
    data['cardClass'] = this._cardClass;
    data['collectible'] = this._collectible;
    data['cost'] = this._cost;
    data['elite'] = this._elite;
    data['faction'] = this._faction;
    data['health'] = this._health;
    data['mechanics'] = this._mechanics;
    data['rarity'] = this._rarity;
    data['set'] = this._set;
    data['type'] = this._type;
    return data;
  }
}

class CardModelTmp {
  int _id;
  int _collectible;
  String _slug;
  int _classId;
  List<int> _multiClassIds;
  int _cardTypeId;
  int _cardSetId;
  int _rarityId;
  String _artistName;
  int _manaCost;
  Name _name;
  Name _text;
  Name _image;
  Name _imageGold;
  Name _flavorText;
  String _cropImage;
  Duels _duels;
  List<int> _childIds;

  CardModelTmp(
      {int id,
      int collectible,
      String slug,
      int classId,
      List<int> multiClassIds,
      int cardTypeId,
      int cardSetId,
      int rarityId,
      String artistName,
      int manaCost,
      Name name,
      Name text,
      Name image,
      Name imageGold,
      Name flavorText,
      String cropImage,
      Duels duels,
      List<int> childIds}) {
    this._id = id;
    this._collectible = collectible;
    this._slug = slug;
    this._classId = classId;
    this._multiClassIds = multiClassIds;
    this._cardTypeId = cardTypeId;
    this._cardSetId = cardSetId;
    this._rarityId = rarityId;
    this._artistName = artistName;
    this._manaCost = manaCost;
    this._name = name;
    this._text = text;
    this._image = image;
    this._imageGold = imageGold;
    this._flavorText = flavorText;
    this._cropImage = cropImage;
    this._duels = duels;
    this._childIds = childIds;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get collectible => _collectible;
  set collectible(int collectible) => _collectible = collectible;
  String get slug => _slug;
  set slug(String slug) => _slug = slug;
  int get classId => _classId;
  set classId(int classId) => _classId = classId;
  List<int> get multiClassIds => _multiClassIds;
  set multiClassIds(List<int> multiClassIds) => _multiClassIds = multiClassIds;
  int get cardTypeId => _cardTypeId;
  set cardTypeId(int cardTypeId) => _cardTypeId = cardTypeId;
  int get cardSetId => _cardSetId;
  set cardSetId(int cardSetId) => _cardSetId = cardSetId;
  int get rarityId => _rarityId;
  set rarityId(int rarityId) => _rarityId = rarityId;
  String get artistName => _artistName;
  set artistName(String artistName) => _artistName = artistName;
  int get manaCost => _manaCost;
  set manaCost(int manaCost) => _manaCost = manaCost;
  Name get name => _name;
  set name(Name name) => _name = name;
  Name get text => _text;
  set text(Name text) => _text = text;
  Name get image => _image;
  set image(Name image) => _image = image;
  Name get imageGold => _imageGold;
  set imageGold(Name imageGold) => _imageGold = imageGold;
  Name get flavorText => _flavorText;
  set flavorText(Name flavorText) => _flavorText = flavorText;
  String get cropImage => _cropImage;
  set cropImage(String cropImage) => _cropImage = cropImage;
  Duels get duels => _duels;
  set duels(Duels duels) => _duels = duels;
  List<int> get childIds => _childIds;
  set childIds(List<int> childIds) => _childIds = childIds;

  CardModelTmp.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _collectible = json['collectible'];
    _slug = json['slug'];
    _classId = json['classId'];

    _multiClassIds = json['multiClassIds'] != null &&
            (json['multiClassIds'] as List).length > 0
        ? json['multiClassIds'].cast<int>()
        : [];
    _cardTypeId = json['cardTypeId'];
    _cardSetId = json['cardSetId'];
    _rarityId = json['rarityId'];
    _artistName = json['artistName'];
    _manaCost = json['manaCost'];
    _name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    _text = json['text'] != null ? new Name.fromJson(json['text']) : null;
    _image = json['image'] != null ? new Name.fromJson(json['image']) : null;
    _imageGold =
        json['imageGold'] != null ? new Name.fromJson(json['imageGold']) : null;
    _flavorText = json['flavorText'] != null
        ? new Name.fromJson(json['flavorText'])
        : null;
    _cropImage = json['cropImage'];
    _duels = json['duels'] != null ? new Duels.fromJson(json['duels']) : null;
    _childIds =
        json['childIds'] != null && (json['childIds'] as List).length > 0
            ? json['childIds'].cast<int>()
            : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['collectible'] = this._collectible;
    data['slug'] = this._slug;
    data['classId'] = this._classId;
    data['multiClassIds'] = this._multiClassIds;
    data['cardTypeId'] = this._cardTypeId;
    data['cardSetId'] = this._cardSetId;
    data['rarityId'] = this._rarityId;
    data['artistName'] = this._artistName;
    data['manaCost'] = this._manaCost;
    if (this._name != null) {
      data['name'] = this._name.toJson();
    }
    if (this._text != null) {
      data['text'] = this._text.toJson();
    }
    if (this._image != null) {
      data['image'] = this._image.toJson();
    }
    if (this._imageGold != null) {
      data['imageGold'] = this._imageGold.toJson();
    }
    if (this._flavorText != null) {
      data['flavorText'] = this._flavorText.toJson();
    }
    data['cropImage'] = this._cropImage;
    if (this._duels != null) {
      data['duels'] = this._duels.toJson();
    }
    data['childIds'] = this._childIds;
    return data;
  }
}

class Name {
  String _deDE;
  String _enUS;
  String _esES;
  String _esMX;
  String _frFR;
  String _itIT;
  String _jaJP;
  String _koKR;
  String _plPL;
  String _ptBR;
  String _ruRU;
  String _thTH;
  String _zhCN;
  String _zhTW;

  Name(
      {String deDE,
      String enUS,
      String esES,
      String esMX,
      String frFR,
      String itIT,
      String jaJP,
      String koKR,
      String plPL,
      String ptBR,
      String ruRU,
      String thTH,
      String zhCN,
      String zhTW}) {
    this._deDE = deDE;
    this._enUS = enUS;
    this._esES = esES;
    this._esMX = esMX;
    this._frFR = frFR;
    this._itIT = itIT;
    this._jaJP = jaJP;
    this._koKR = koKR;
    this._plPL = plPL;
    this._ptBR = ptBR;
    this._ruRU = ruRU;
    this._thTH = thTH;
    this._zhCN = zhCN;
    this._zhTW = zhTW;
  }

  String get deDE => _deDE;
  set deDE(String deDE) => _deDE = deDE;
  String get enUS => _enUS;
  set enUS(String enUS) => _enUS = enUS;
  String get esES => _esES;
  set esES(String esES) => _esES = esES;
  String get esMX => _esMX;
  set esMX(String esMX) => _esMX = esMX;
  String get frFR => _frFR;
  set frFR(String frFR) => _frFR = frFR;
  String get itIT => _itIT;
  set itIT(String itIT) => _itIT = itIT;
  String get jaJP => _jaJP;
  set jaJP(String jaJP) => _jaJP = jaJP;
  String get koKR => _koKR;
  set koKR(String koKR) => _koKR = koKR;
  String get plPL => _plPL;
  set plPL(String plPL) => _plPL = plPL;
  String get ptBR => _ptBR;
  set ptBR(String ptBR) => _ptBR = ptBR;
  String get ruRU => _ruRU;
  set ruRU(String ruRU) => _ruRU = ruRU;
  String get thTH => _thTH;
  set thTH(String thTH) => _thTH = thTH;
  String get zhCN => _zhCN;
  set zhCN(String zhCN) => _zhCN = zhCN;
  String get zhTW => _zhTW;
  set zhTW(String zhTW) => _zhTW = zhTW;

  Name.fromJson(Map<String, dynamic> json) {
    _deDE = json['de_DE'];
    _enUS = json['en_US'];
    _esES = json['es_ES'];
    _esMX = json['es_MX'];
    _frFR = json['fr_FR'];
    _itIT = json['it_IT'];
    _jaJP = json['ja_JP'];
    _koKR = json['ko_KR'];
    _plPL = json['pl_PL'];
    _ptBR = json['pt_BR'];
    _ruRU = json['ru_RU'];
    _thTH = json['th_TH'];
    _zhCN = json['zh_CN'];
    _zhTW = json['zh_TW'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['de_DE'] = this._deDE;
    data['en_US'] = this._enUS;
    data['es_ES'] = this._esES;
    data['es_MX'] = this._esMX;
    data['fr_FR'] = this._frFR;
    data['it_IT'] = this._itIT;
    data['ja_JP'] = this._jaJP;
    data['ko_KR'] = this._koKR;
    data['pl_PL'] = this._plPL;
    data['pt_BR'] = this._ptBR;
    data['ru_RU'] = this._ruRU;
    data['th_TH'] = this._thTH;
    data['zh_CN'] = this._zhCN;
    data['zh_TW'] = this._zhTW;
    return data;
  }
}

class Duels {
  bool _relevant;
  bool _constructed;

  Duels({bool relevant, bool constructed}) {
    this._relevant = relevant;
    this._constructed = constructed;
  }

  bool get relevant => _relevant;
  set relevant(bool relevant) => _relevant = relevant;
  bool get constructed => _constructed;
  set constructed(bool constructed) => _constructed = constructed;

  Duels.fromJson(Map<String, dynamic> json) {
    _relevant = json['relevant'];
    _constructed = json['constructed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relevant'] = this._relevant;
    data['constructed'] = this._constructed;
    return data;
  }
}
