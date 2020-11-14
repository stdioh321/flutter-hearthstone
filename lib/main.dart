import 'package:flutter/material.dart';
import 'package:hearthstonecatalog/pages/HomePage.dart';
import 'package:hearthstonecatalog/providers/CardsProv.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CardsProv(),
      child: MaterialApp(
        title: 'Hearthstone Catalog',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        initialRoute: "/",
        routes: {
          "/": (_) => HomePage(),
        },
      ),
    );
  }
}
