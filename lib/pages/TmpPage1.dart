import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:hearthstonecatalog/pages/TmpPage2.dart';

class TmpPage1 extends StatefulWidget {
  @override
  _TmpPage1State createState() => _TmpPage1State();
}

class _TmpPage1State extends State<TmpPage1> {
  final _animKey = AnimatorKey<double>(initialValue: 30.0);

  @override
  Widget build(BuildContext context) {
    print('build1');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _animKey.triggerAnimation(restart: false);
        },
        child: Icon(
          Icons.send,
        ),
      ),
      appBar: AppBar(
        title: Text("Tmp1"),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Animator<double>(
                animatorKey: _animKey,
                tween: Tween(begin: 10.0, end: 100.0),
                duration: Duration(milliseconds: 3000),
                cycles: 1,
                curve: Curves.bounceInOut,
                builder: (context, animatorState, child) {
                  return Container(
                    height: animatorState.value,
                    width: animatorState.value,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.red,
                      width: 2,
                    )),
                    child: Text('TMP'),
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => TmpPage2(),
                    ),
                  );
                },
                child: Text('Tmp2'),
              ),
            ],
          )),
    );
  }
}
