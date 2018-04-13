import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String user;
  String pwd;

  @override
  Widget build(BuildContext context) {
    var inputStyle = new TextStyle(fontSize: 30.0, color: Colors.black);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('登录'),
      ),
      body: new Form(
        child: new Center(
            child: new Padding(
          padding: const EdgeInsets.only(left: 40.0, top: 100.0, right: 40.0),
          child: new Column(
            children: <Widget>[
              new TextField(
                onChanged: (text) {
                  this.user = text;
                },
                style: inputStyle,
              ),
              new TextField(
                onChanged: (text) {
                  this.pwd = text;
                },
                style: inputStyle,
                keyboardType: TextInputType.text,
              ),
              new RaisedButton(onPressed: () {
              })
            ],
          ),
        )),
      ),
    );
  }
}
