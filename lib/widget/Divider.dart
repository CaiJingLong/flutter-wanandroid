import 'package:flutter/material.dart';

class MyDivider extends StatefulWidget {
  @override
  _DividerState createState() => new _DividerState();
}

class _DividerState extends State<MyDivider> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          border: new Border(
              top: new BorderSide(
                color: Theme
                    .of(context)
                    .dividerColor,
                width: 1.0,
              ))),
    );
  }
}
