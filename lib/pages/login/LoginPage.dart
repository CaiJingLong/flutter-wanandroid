import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  String user = "";
  String pwd = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('登录'),
        ),
        body: new Builder(builder: (ctx) {
          return _buildContent(ctx);
        }));
  }

  Padding _buildContent(BuildContext context) {
    var inputStyle = new TextStyle(fontSize: 30.0, color: Colors.black);
    return new Padding(
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
          new RaisedButton(
            onPressed: () {
              if (user.isEmpty) {
                Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("用户名不能为空")));
                return;
              }
              if (pwd.isEmpty) {
                Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("用户名不能为空")));
                return;
              }
            },
          )
        ],
      ),
    );
  }

  void submit() {}
}
