import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:hearthstonecatalog/models/CardModel.dart';
import 'package:hearthstonecatalog/providers/CardsProv.dart';
import 'package:hearthstonecatalog/services/Api.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class CardViewer extends StatefulWidget {
  CardModel card;
  CardViewer({@required this.card});
  @override
  _CardViewerState createState() => _CardViewerState();
}

class _CardViewerState extends State<CardViewer> {
  CardsProv cardsProv;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(Api.instance.urlImage256 + widget.card.id + ".png");
  }

  @override
  Widget build(BuildContext context) {
    cardsProv = cardsProv ?? Provider.of<CardsProv>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.card.name,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 6,
                    child: Container(
                      constraints: BoxConstraints(minHeight: 200),
                      child: GestureDetector(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return Container(
                                // padding: EdgeInsets.all(50),
                                child: Scaffold(
                                  appBar: AppBar(
                                    title: Text(
                                      widget.card.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  body: PhotoView(
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Image.asset(
                                          "assets/images/card-placeholder.png",
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    },
                                    loadingBuilder: (context, event) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    imageProvider:
                                        NetworkImage(cardsProv.getImage(
                                      widget.card,
                                      img512: true,
                                    )),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl:
                              "${Api.instance.urlImage256}${widget.card.id}.png",
                          placeholder: (context, url) {
                            return Container(
                              padding: EdgeInsets.all(15),
                              child: Image.asset(
                                "card-placeholder.png",
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Container(
                              padding: EdgeInsets.all(15),
                              child: Center(
                                child: Image.asset(
                                    'assets/images/image-not-found.png'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          widget.card.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Class: ${widget.card.cardClass}",
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Rarity: ${widget.card.rarity}",
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Set: ${widget.card.set}",
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Type: ${widget.card.type}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                child: HtmlWidget(
                  widget.card.text ?? "",
                  textStyle: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
          // PhotoView(
          //   imageProvider: NetworkImage(widget.card.image.enUS),
          // ),
        ),
      ),
    );
  }
}
