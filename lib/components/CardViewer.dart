import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hearthstonecatalog/models/CardModel.dart';
import 'package:hearthstonecatalog/services/Api.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CardViewer extends StatefulWidget {
  CardModel card;
  CardViewer({@required this.card});
  @override
  _CardViewerState createState() => _CardViewerState();
}

class _CardViewerState extends State<CardViewer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(jsonEncode(widget.card));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.card.name,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        child: Center(
          child: CachedNetworkImage(
            imageUrl: "${Api.instance.urlImage512}${widget.card.id}.png",
            placeholder: (context, url) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Image.asset('assets/images/image-not-found.png'),
                ),
              );
            },
          ),
        ),
        // PhotoView(
        //   imageProvider: NetworkImage(widget.card.image.enUS),
        // ),
      ),
    );
  }
}
