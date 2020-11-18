import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hearthstonecatalog/pages/HomePage.dart';
import 'package:hearthstonecatalog/providers/CardsProv.dart';
import 'package:hearthstonecatalog/services/Prefs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load SharedPreferences
  await loadPrefs();
  // Than we setup preferred orientations,
  // and only after it finished we run our app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

loadPrefs() async {
  Prefs.instance.prefs = await SharedPreferences.getInstance();
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CardsProv(),
      child: MaterialApp(
        title: 'Hearthstone Catalog',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            // brightness: Prefs.instance.getBrightness()
            //     ? Brightness.dark
            //     : Brightness.light,
            brightness: Brightness.dark),
        initialRoute: "/",
        routes: {
          "/": (_) => HomePage(),
        },
      ),
    );
  }
}
