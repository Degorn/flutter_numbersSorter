import 'package:flutter/material.dart';

class DraggableNumber extends StatefulWidget {
  final bool isDragged;
  final String content;

  DraggableNumber({this.content, this.isDragged = false});

  @override
  State<DraggableNumber> createState() {
    return _DraggableNumberNormalState(isDragged);
  }
}

class _DraggableNumberNormalState extends State<DraggableNumber> {
  bool isDragged;

  _DraggableNumberNormalState(this.isDragged);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isDragged ? 72 : 80,
      height: isDragged ? 72 : 80,
      child: Center(
        child: Text(
          widget.content,
          style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              decoration: TextDecoration.none),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
        boxShadow: isDragged
            ? const [
                BoxShadow(
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
    );
  }
}
