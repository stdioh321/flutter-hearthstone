import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hearthstonecatalog/models/CardModel.dart';
import 'package:hearthstonecatalog/services/Api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CardModel> _cards = [];
  List<CardModel> cards = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    _loadCards();
  }

  _loadCards() async {
    _cards = await Api.instance.getCards() ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards"),
      ),
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          children: _cards.map((e) {
            return Image.network(
              e.image.enUS,
              fit: BoxFit.contain,
            );
          }).toList(),
        ),
      ),
    );
  }
}
