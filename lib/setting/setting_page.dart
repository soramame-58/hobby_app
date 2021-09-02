import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '設定画面',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.accessibility),
            title: Text("魅力的な人達"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text("気になった投稿"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.access_alarm_outlined),
            title: Text("通知設定"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.wc),
            title: Text("紹介"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.accessibility_new),
            title: Text("ご意見、ご要望"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.add_to_drive),
            title: Text("環境設定"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.warning_amber_outlined),
            title: Text("ログアウト"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
