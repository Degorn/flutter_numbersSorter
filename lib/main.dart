import 'dart:math';
import 'package:flutter/material.dart';

import 'customs/draggable_number.dart';
import 'customs/my_drag_target.dart';
import 'infrastructure/condition_manager.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyApp());
  }
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final random = Random();

  int _number;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  ConditionManager conditionManager;

  @override
  Widget build(BuildContext context) {
    conditionManager = ConditionManager(0, 10);

    generateNumber();

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(32),
        child: AppBar(
          title: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Drag the number to the ',
              ),
              TextSpan(
                  text: 'correct',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              TextSpan(
                text: ' cell',
              ),
            ]),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            child: Draggable(
              data: _number,
              child: DraggableNumber(
                content: _number.toString(),
              ),
              feedback: DraggableNumber(
                content: _number.toString(),
                isDragged: true,
              ),
              childWhenDragging: PlaceholderNumberState(),
            ),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MyDragTarget(
                scaffoldKey: scaffoldKey,
                value: conditionManager.minValue.toString(),
                isLess: true,
                mean: conditionManager.mean,
              ),
              MyDragTarget(
                scaffoldKey: scaffoldKey,
                value: conditionManager.maxValue.toString(),
                isLess: false,
                mean: conditionManager.mean,
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          generateNumber();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  void generateNumber() {
    return setState(() {
      _number = conditionManager.minValue +
          random.nextInt(conditionManager.maxValue - conditionManager.minValue);
    });
  }
}

class PlaceholderNumberState extends StatelessWidget {
  const PlaceholderNumberState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
          border: generateBorder(), borderRadius: BorderRadius.circular(8)),
    );
  }

  Border generateBorder() {
    final borderSize = BorderSide(width: 1, color: Colors.grey);

    return Border(
      left: borderSize,
      right: borderSize,
      top: borderSize,
      bottom: borderSize,
    );
  }
}
