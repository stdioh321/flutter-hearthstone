import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hearthstonecatalog/components/CardViewer.dart';
import 'package:hearthstonecatalog/models/CardModel.dart';
import 'package:hearthstonecatalog/providers/CardsProv.dart';
import 'package:hearthstonecatalog/services/Api.dart';
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
  List<CardModel> _cards = [];
  TextEditingController _searchCtrl = TextEditingController(text: "");
  Status statusCards = Status.loading;
  ScrollController _cardsScrollCtrl = ScrollController();
  String lang = "enUS";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (cardsProv == null) {
      cardsProv = Provider.of<CardsProv>(context);
      _loadCardProv();
    }
  }

  _loadCardProv({String lang: 'enUS'}) async {
    cardsProv.cardsStatus = Status.loading;
    _searchCtrl.text = "";
    try {
      await cardsProv.loadCards(lang: lang);
      _cards = cardsProv.cards;
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
      List cardsGrid =
          cardsProv.getFilterdCards(search: _searchCtrl.text).map((card) {
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
                      AudioPlayer audioPlayer = AudioPlayer();

                      try {
                        String tmpUrl = Api.instance.getSound(card);

                        await audioPlayer.play(tmpUrl, isLocal: false);
                        print(tmpUrl);
                        // await _ctrl.play();
                      } catch (e) {
                        print(e);
                      }
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CardViewer(card: card)),
                      );
                      audioPlayer.stop();
                      print("Pop CardViewer");
                    },
                    child: CachedNetworkImage(
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
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
          ),
        );
      return GridView.count(
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          cardsProv.cardsStatus != Status.ok
              ? SizedBox()
              : DropdownButton(
                  iconSize: 0,
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
                  onChanged: (value) {
                    print(value);
                    if (value == lang) return;
                    _loadCardProv(lang: value);
                    setState(() {
                      lang = value;
                    });
                  },
                ),
        ],
        title: TextFormField(
          controller: _searchCtrl,
          enabled: cardsProv.cardsStatus == Status.ok,
          onChanged: (v) {
            Utils.instance.run(() {
              cardsProv.notifyListeners();
              _cardsScrollCtrl?.animateTo(
                0,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
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
