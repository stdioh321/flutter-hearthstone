import 'package:flutter/material.dart';
import 'package:hearthstonecatalog/models/FilterModel.dart';
import 'package:hearthstonecatalog/services/Vars.dart';

class FilterModal extends StatefulWidget {
  FilterModel filters;
  FilterModal({@required this.filters}) {}

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: Container(
          // alignment: Alignment.topLeft,
          // decoration: BoxDecoration(
          //     border: Border.all(
          //   color: Colors.red,
          //   width: 2,
          // )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                mini: true,
                backgroundColor: Colors.red[700],
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  // print(widget.filters.cardType);
                  setState(() {
                    widget.filters.reset();
                  });
                },
              ),
              FloatingActionButton(
                mini: true,
                backgroundColor: Colors.green[700],
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: () {
                  // print(widget.filters.cardType);
                  Navigator.pop(context, widget.filters);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: SizedBox(),
          title: Text("Filter"),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Text("Card Class",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    )),
              ),
              SliverGrid.count(
                crossAxisCount: 2,
                childAspectRatio: 9,
                children:
                    (Vars.instance.cardOptions['cardClasses'] as List).map((e) {
                  var cardClass = widget.filters.cardClasses;
                  bool v = cardClass[e] == true ? true : false;
                  return CheckboxListTile(
                    title: Text(e),
                    value: v,
                    onChanged: (v) {
                      cardClass[e] = v;
                      setState(() {});
                    },
                  );
                }).toList(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: Text("Rarity",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    )),
              ),
              SliverGrid.count(
                crossAxisCount: 2,
                childAspectRatio: 9,
                children:
                    (Vars.instance.cardOptions['rarity'] as List).map((e) {
                  var rarity = widget.filters.rarity;
                  bool v = rarity[e] == true ? true : false;
                  return CheckboxListTile(
                    title: Text(e),
                    value: v,
                    onChanged: (v) {
                      rarity[e] = v;
                      setState(() {});
                    },
                  );
                }).toList(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: Text("Card Type",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    )),
              ),
              SliverGrid.count(
                crossAxisCount: 2,
                childAspectRatio: 9,
                children:
                    (Vars.instance.cardOptions['cardType'] as List).map((e) {
                  var cardType = widget.filters.cardType;
                  bool v = cardType[e] == true ? true : false;
                  return CheckboxListTile(
                    title: Text(e),
                    value: v,
                    onChanged: (v) {
                      cardType[e] = v;
                      setState(() {});
                    },
                  );
                }).toList(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: Text("Cost",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    )),
              ),
              SliverGrid.count(
                crossAxisCount: 4,
                childAspectRatio: 4,
                children: List.generate(13, (index) => "${index}").map((e) {
                  var cost = widget.filters.cost;
                  bool v = cost[e] == true ? true : false;
                  return CheckboxListTile(
                    value: v,
                    title: Text(e),
                    onChanged: (value) {
                      setState(() {
                        cost[e] = value;
                      });
                      // print(cost[e]);
                      // print(value); // print(value);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ));
  }
}
