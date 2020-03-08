import 'package:flutter/material.dart';

class MyDragTarget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String value;
  final bool isLess;
  final int mean;

  const MyDragTarget({this.scaffoldKey, this.value, this.isLess, this.mean});

  @override
  Widget build(BuildContext context) {
    var dragTarget = DragTarget(
      builder:
          (BuildContext context, List<int> candidateData, List rejectedData) =>
              buildContainer(candidateData),
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        if (isLess ? data < mean : data > mean) {
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text("Correct!"),
            duration: Duration(milliseconds: 400),
          ));
        } else {
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text("Wrong!"),
            duration: Duration(milliseconds: 400),
          ));
        }
      },
    );
    return dragTarget;
  }

  Widget buildContainer(List candidateData) {
    var containerColor =
        candidateData.length != 0 ? Colors.grey : Colors.orange;

    return Container(
      width: 80,
      height: 80,
      color: containerColor,
      child: Center(
        child: Text(
          isLess ? '<$mean' : '>$mean',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
          ),
        ),
      ),
    );
  }
}
