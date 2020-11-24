import 'package:animator/animator.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:hearthstonecatalog/models/CardModel.dart';
import 'package:hearthstonecatalog/services/Api.dart';
import 'package:hearthstonecatalog/services/Utils.dart';
import 'package:photo_view/photo_view.dart';

class CardDetails extends StatefulWidget {
  CardModel card;
  CardDetails({@required this.card});

  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  // CardsProv cardsProv;
  AudioPlayer tmpAudio = AudioPlayer();
  bool audioOk = false;

  @override
  void dispose() {
    // TODO: implement dispose
    tmpAudio.stop();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAudioOk();
    // print(Api.instance.urlImage256 + widget.card.id + ".png");
  }

  checkAudioOk() async {
    // print('checkAudioOk');
    try {
      audioOk = await Utils.instance
                  .checkUrlWorks(Api.instance.getSound(widget.card)) ==
              true
          ? true
          : false;
    } catch (e) {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // cardsProv = cardsProv ?? Provider.of<CardsProv>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.card.name,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          audioOk == true
              ? IconButton(
                  icon: Icon(
                    Icons.volume_up,
                  ),
                  onPressed: () async {
                    try {
                      await tmpAudio.stop();
                      String tmpUrl = Api.instance.getSound(widget.card);
                      await tmpAudio.play(tmpUrl);
                    } catch (e) {
                      print(e);
                    }
                  },
                )
              : SizedBox()
        ],
      ),
      body: SingleChildScrollView(
        child: Animator<double>(
          builder: (context, animatorState, child) {
            return Opacity(
              opacity: animatorState.value,
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
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Image.asset(
                                                "assets/images/card-placeholder.png",
                                                fit: BoxFit.contain,
                                              ),
                                            );
                                          },
                                          loadingBuilder: (context, event) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                          imageProvider: NetworkImage(
                                              Api.instance.getImage(
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
                    widget.card.howToEarnGolden == null
                        ? SizedBox()
                        : Animator<double>(
                            repeats: 1,
                            tween: Tween<double>(begin: -200.0, end: 0.0),
                            // curve: Curves.decelerate,
                            // duration: Duration(milliseconds: 1500),
                            builder: (context, animatorState2, child) {
                              return Transform.translate(
                                offset: Offset(animatorState2.value, 0.0),
                                // transform: Matrix4.translation(Vector),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(),
                                      // SizedBox(height: 20),
                                      Container(
                                        // decoration: BoxDecoration(
                                        //     border:
                                        //         Border.all(width: 1, color: Colors.red)),
                                        child: Text(
                                          "How to Earn Golden",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      Container(
                                        child:
                                            Text(widget.card.howToEarnGolden),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
                // PhotoView(
                //   imageProvider: NetworkImage(widget.card.image.enUS),
                // ),
              ),
            );
          },
        ),
      ),
    );
  }
}
