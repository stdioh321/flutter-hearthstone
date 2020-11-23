import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hearthstonecatalog/components/CardViewer.dart';
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
        } else if (currSort.label == 'Health') {
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
                              CardViewer(card: card),
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

      return GridView.count(
        // shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.7239,
        mainAxisSpacing: 20,
        controller: _cardsScrollCtrl,
        children: cardsGrid,
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          cardsProv.cardsStatus != Status.ok
              ? SizedBox()
              : PopupMenuButton<SortModel>(
                  icon: Icon(Icons.sort),
                  tooltip: "Sort",
                  onSelected: (value) {
                    Utils.instance.removeFocus(context);
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: EdgeInsets.fromLTRB(45, 30, 45, 30),
                          child: FilterModal(
                            filters: tmpFilters,
                          ),
                        );
                      },
                    );

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
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: "ptBR",
                        child: Center(
                          child: Image.asset(
                            'assets/images/flags/flag-brasil.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) async {
                      // print(value);
                      if (value == lang) return;
                      await Prefs.instance.prefs.setString("lang", value);
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
        title: TextFormField(
          controller: _searchCtrl,
          enabled: cardsProv.cardsStatus == Status.ok,
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
          decoration: InputDecoration(hintText: "Search..."),
        ),
      ),
      body: Container(
        child: _buildBody(),
      ),
    );
  }
}
