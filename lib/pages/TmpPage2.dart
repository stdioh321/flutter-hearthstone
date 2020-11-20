import 'package:flutter/material.dart';

class TmpPage2 extends StatefulWidget {
  @override
  _TmpPage2State createState() => _TmpPage2State();
}

class _TmpPage2State extends State<TmpPage2> {
  @override
  Widget build(BuildContext context) {
    print('build2');
    return Scaffold(
      appBar: AppBar(
        title: Text("Tmp2"),
      ),
      body: Center(
        child: Text("Center"),
      ),
    );
  }
}
