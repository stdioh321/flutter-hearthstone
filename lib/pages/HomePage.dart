import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hearthstonecatalog/pages/CardDetails.dart';
import 'package:hearthstonecatalog/components/FilterModal.dart';
import 'package:hearthstonecatalog/models/FilterModel.dart';
import 'package:hearthstonecatalog/models/SortModel.dart';
import 'package:hearthstonecatalog/providers/CardsProv.dart';
import 'package:hearthstonecatalog/services/Api.dart';
import 'package:hearthstonecatalog/services/Prefs.dart';
import 'package:hearthstonecatalog/services/Status.dart';
import 'package:hearthstonecatalog/services/Utils.dart';
import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CardsProv cardsProv = null;

  TextEditingController _searchCtrl = TextEditingController(text: "");
  Status statusCards = Status.loading;
  ScrollController _cardsScrollCtrl = ScrollController();
  String lang = Prefs.instance.prefs.getString("lang") ?? "enUS";

  List<SortModel> sortsList =
      SortModel.types.map((e) => SortModel(label: e, dir: "asc")).toList();
  SortModel currSort;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currSort = sortsList[0];
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (cardsProv == null) {
      cardsProv = Provider.of<CardsProv>(context);
      _loadCardProv(lang: lang);
    }
  }

  _loadCardProv({String lang: 'enUS'}) async {
    cardsProv.cardsStatus = Status.loading;
    _searchCtrl.text = "";
    cardsProv.filters.reset();
    currSort = sortsList[0];
    try {
      await cardsProv.loadCards(lang: lang);
      // _cards = cardsProv.cards;
      cardsProv.cardsStatus = Status.ok;
      // statusCards = Status.ok;
      // setState(() {});
    } catch (e) {
      print("ERROR: ");
      print(e);
      cardsProv.cardsStatus = Status.error;
    }
    cardsProv.notifyListeners();
  }

  _buildBody() {
    if (cardsProv.cardsStatus == Status.loading ||
        cardsProv.cardsStatus == Status.none) {
      return Center(
        child: Container(
          height: 100,
          child: Image.asset(
            "assets/images/loading.gif",
            fit: BoxFit.contain,
          ),
        ),
      );
    } else if (cardsProv.cardsStatus == Status.ok) {
      // int idx = 1;
      cardsProv.cards.sort((a, b) {
        int result = 0;
        if (currSort.label == 'A-Z') {
          result = a.name
              .trim()
              .toLowerCase()
              .compareTo(b.name.trim().toLowerCase());
        } else if (currSort.label == 'Mana') {
          result = ((a.cost ?? 0) - (b.cost ?? 0));
        } else if (currSort.label == 'Atk') {
          result = ((a.attack ?? 0) - (b.attack ?? 0));
        } else if (currSort.label == 'Health' &&
            a.type != "HERO" &&
            b.type != "HERO") {
          result = ((a.health ?? 0) - (b.health ?? 0));
        }
        return result * (currSort.dir == "desc" ? -1 : 1);
      });
      List cardsGrid = cardsProv.cards.map((card) {
        return Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  card.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Flexible(
                child: Container(
                  child: GestureDetector(
                    onTap: () async {
                      Utils.instance.removeFocus(context);

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CardDetails(card: card),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      imageBuilder: (context, imageProvider) {
                        return Animator<double>(
                          tween: Tween(begin: -80.0, end: 0.0),
                          cycles: 1,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 400),
                          builder: (context, animatorState, child) {
                            return Transform.translate(
                              offset: Offset(animatorState.value, 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      imageUrl: "${Api.instance.urlImage256}${card.id}.png",
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/images/image-not-found.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList();

      if (cardsGrid?.length < 1)
        return Center(
          child: Text(
            'Empty',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
            ),
          ),
        );

      return Stack(
        children: [
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.7239,
            mainAxisSpacing: 20,
            controller: _cardsScrollCtrl,
            children: cardsGrid,
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, right: 5),
            child: Container(
                alignment: Alignment.topRight,
                child: Text("${cardsProv?.cards?.length ?? '0'}",
                    style: TextStyle(fontSize: 10))),
          )
        ],
      );
    } else if (cardsProv.cardsStatus == Status.error) {
      return Center(
        child: Text(
          "Error",
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return GestureDetector(
      onTap: () {
        print("onTap");
        Utils.instance.removeFocus(context);
      },
      child: Scaffold(
        appBar: AppBar(
          actions: true == true
              ? []
              : [
                  cardsProv.cardsStatus != Status.ok
                      ? SizedBox()
                      : PopupMenuButton<SortModel>(
                          icon: Icon(Icons.sort),
                          tooltip: "Sort",
                          offset: Offset(0.0, 20.0),
                          onSelected: (value) {
                            Utils.instance.removeFocus(context);
                            _cardsScrollCtrl.jumpTo(0);
                            // print(value.dir);
                            setState(() {
                              if (value.label == currSort.label) {
                                if (currSort.dir == "desc")
                                  value.dir = "asc";
                                else
                                  value.dir = "desc";
                              } else {
                                value.dir = "asc";
                              }
                              currSort = value;
                            });
                          },
                          onCanceled: () {
                            Utils.instance.removeFocus(context);
                            print('onCanceled');
                          },
                          itemBuilder: (BuildContext context) {
                            return sortsList.map((e) {
                              return PopupMenuItem(
                                value: e,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e.label,
                                      style: TextStyle(
                                          fontWeight: e.label == currSort.label
                                              ? FontWeight.w900
                                              : null),
                                    ),
                                    e.label == currSort.label
                                        ? (currSort.dir == "desc"
                                            ? Icon(Icons.arrow_upward)
                                            : Icon(Icons.arrow_downward))
                                        : SizedBox(),
                                  ],
                                ),
                              );
                            }).toList();
                          },
                        ),
                  cardsProv.cardsStatus != Status.ok
                      ? SizedBox()
                      : IconButton(
                          icon: Icon(Icons.filter_alt),
                          onPressed: () async {
                            var result = await showDialog(
                              context: context,
                              builder: (context) {
                                var tmpFilters = cardsProv.filters.clone();
                                return Container(
                                  padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                                  child: FilterModal(
                                    filters: tmpFilters,
                                  ),
                                );
                              },
                            );
                            Utils.instance.removeFocus(context);
                            if (result.runtimeType == FilterModel) {
                              cardsProv.filters = result;
                              cardsProv.execFilterCards(
                                  search: _searchCtrl.text, filters: result);
                              _cardsScrollCtrl?.animateTo(0,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeInOut);
                            }

                            // print
                            // cardsProv.notifyListeners();
                          },
                        ),
                  cardsProv.cardsStatus != Status.ok
                      ? SizedBox()
                      : DropdownButtonHideUnderline(
                          child: DropdownButton(
                            iconSize: 0,
                            // isDense: true,
                            style: TextStyle(decoration: TextDecoration.none),
                            underline: null,
                            value: lang,
                            items: [
                              DropdownMenuItem(
                                value: "enUS",
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/flags/flag-usa.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "ptBR",
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/flags/flag-brasil.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) async {
                              Utils.instance.removeFocus(context);
                              if (value == lang) return;
                              await Prefs.instance.prefs
                                  .setString("lang", value);
                              _loadCardProv(lang: value);
                              setState(() {
                                lang = value;
                              });
                            },
                          ),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                ],
          title: Container(
            // height: 43.0,
            // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            child: Expanded(
              // flex: 1,
              child: TextFormField(
                controller: _searchCtrl,
                enabled: cardsProv.cardsStatus == Status.ok,
                onEditingComplete: () {
                  Utils.instance.removeFocus(context);
                },
                onFieldSubmitted: (v) {
                  Utils.instance.removeFocus(context);
                },
                onChanged: (v) {
                  Utils.instance.run(() {
                    cardsProv.execFilterCards(
                      search: _searchCtrl.text,
                      filters: cardsProv.filters,
                    );
                    _cardsScrollCtrl?.animateTo(0,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  }, 300);
                },
                decoration: InputDecoration(
                  // helperText: "${cardsProv?.cards?.length ?? '0'}",
                  // contentPadding: EdgeInsets.all(10),
                  // disabledBorder: InputBorder.none,

                  // helperStyle: TextStyle(backgroundColor: Colors.red),
                  // labelText: _searchCtrl.text.isNotEmpty
                  //     ? "${cardsProv?.cards?.length ?? '0'}"
                  //     : null,
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: cardsProv.cardsStatus != Status.ok
                        ? []
                        : [
                            Container(
                              width: 35,
                              child: PopupMenuButton<SortModel>(
                                icon: Icon(
                                  Icons.sort,
                                  color: Colors.white,
                                ),
                                tooltip: "Sort",
                                // offset: Offset(0.0, 20.0),
                                onSelected: (value) {
                                  Utils.instance.removeFocus(context);
                                  _cardsScrollCtrl?.jumpTo(0);
                                  // print(value.dir);
                                  setState(() {
                                    if (value.label == currSort.label) {
                                      if (currSort.dir == "desc")
                                        value.dir = "asc";
                                      else
                                        value.dir = "desc";
                                    } else {
                                      value.dir = "asc";
                                    }
                                    currSort = value;
                                  });
                                },
                                onCanceled: () {
                                  Utils.instance.removeFocus(context);
                                  print('onCanceled');
                                },
                                itemBuilder: (BuildContext context) {
                                  return sortsList.map((e) {
                                    return PopupMenuItem(
                                      value: e,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e.label,
                                            style: TextStyle(
                                                fontWeight:
                                                    e.label == currSort.label
                                                        ? FontWeight.w900
                                                        : null),
                                          ),
                                          e.label == currSort.label
                                              ? (currSort.dir == "desc"
                                                  ? Icon(Icons.arrow_upward)
                                                  : Icon(Icons.arrow_downward))
                                              : SizedBox(),
                                        ],
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                            Container(
                              width: 35,
                              child: IconButton(
                                icon: Icon(
                                  Icons.filter_alt,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  var result = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      var tmpFilters =
                                          cardsProv.filters.clone();
                                      return Container(
                                        padding:
                                            EdgeInsets.fromLTRB(30, 30, 30, 30),
                                        child: FilterModal(
                                          filters: tmpFilters,
                                        ),
                                      );
                                    },
                                  );

                                  if (result.runtimeType == FilterModel) {
                                    cardsProv.filters = result;
                                    cardsProv.execFilterCards(
                                        search: _searchCtrl.text,
                                        filters: result);
                                    _cardsScrollCtrl?.animateTo(0,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut);
                                  }

                                  // print
                                  // cardsProv.notifyListeners();
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 35,
                              child: GestureDetector(
                                onTap: () {
                                  Utils.instance.removeFocus(context);
                                },
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    iconSize: 0,
                                    // isDense: true,
                                    style: TextStyle(
                                        decoration: TextDecoration.none),
                                    underline: null,
                                    value: lang,
                                    items: [
                                      DropdownMenuItem(
                                        value: "enUS",
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/flags/flag-usa.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "ptBR",
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/flags/flag-brasil.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) async {
                                      // print(value);
                                      if (value == lang) return;
                                      await Prefs.instance.prefs
                                          .setString("lang", value);
                                      _loadCardProv(lang: value);
                                      setState(() {
                                        lang = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                  ),
                  // isDense: true,
                  hintText: "Search...",
                  // helperText: "${cardsProv?.cards?.length ?? '0'}",
                ),
              ),
            ),
          ),
        ),
        body: Container(
          child: _buildBody(),
        ),
      ),
    );
  }
}
