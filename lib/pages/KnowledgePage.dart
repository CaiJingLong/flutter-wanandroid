import 'package:flutter/material.dart';

class KnowledgePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new SizedBox(
          child: new Text('Deliver features faster', textAlign: TextAlign.center),
          width: 50.0,
        ),
        new Expanded(
          child: new Text('Craft beautiful UIs', textAlign: TextAlign.center),
        ),
        new Expanded(
          child: new FittedBox(
            fit: BoxFit.contain, // otherwise the logo will be tiny
            child: const FlutterLogo(),
          ),
        ),
      ],
    );
  }

  const KnowledgePage();
}
