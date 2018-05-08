import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class KProgressWidget extends StatelessWidget {
  final bool isLoading;
  final String text;
  final double size;

  final Color background;

  const KProgressWidget({
    Key key,
    this.isLoading = false,
    @required this.text,
    this.size = 24.0,
    this.background = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget result = new SizedBox(
      child: new CircularProgressIndicator(),
      width: size,
      height: size,
    );
    if (!isLoading) {
      result = new Text(
        text,
        maxLines: 1,
      );
    }
    return new Center(
      child: new ClipRRect(
        borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
        child: new Container(
          color: background,
          alignment: Alignment.bottomCenter,
          child: new Center(
            child: new Padding(
              child: result,
              padding: const EdgeInsets.all(12.0),
            ),
          ),
        ),
      ),
    );
  }
}
