import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/pages/login/LoginPage.dart';

class DrawPage extends StatefulWidget {
  @override
  _DrawPageState createState() => new _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: new Scaffold(
      appBar: new AppBar(
        leading: new Text(''),
        title: new Text('菜单'),
      ),
      body: new Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: new ListView(
          children: <Widget>[
            new AspectRatio(
              aspectRatio: 30 / 15,
              child: new Material(
                child: new Column(
                  children: <Widget>[
                    new FlutterLogo(
                      size: 40.0,
                    ),
                    new Center(child: new Text('未登录')),
                    new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Align(
                        alignment: Alignment.centerRight,
                        child: new SizedBox(
                          child: new InkWell(
                            child: new Text("登录",
                              style: new TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0,
                              ),
                            ),
                            onTap: login,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  login() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
      return new LoginPage();
    }));
  }
}
