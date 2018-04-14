import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String title;
  final String placeholder;
  final ValueChanged<String> onChanged;

  MyTextField({this.title, this.placeholder, this.onChanged});

  @override
  Widget build(BuildContext context) {
    var ctl = new TextEditingController(text: "内容");

    return new Column(
      children: <Widget>[
        new Align(
          child: new Text(title),
          alignment: Alignment.topLeft,
        ),
        new Stack(
          children: <Widget>[
            new TextField(
              onChanged: onChanged,
              controller: ctl,
            ),
          ],
        ),
      ],
    );
  }
}
