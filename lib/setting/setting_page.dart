import 'package:flutter/material.dart';
import 'package:hobby/form/form_page.dart';
import 'package:hobby/introduction/introduction_page.dart';

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
            leading: Icon(Icons.accessibility_new),
            title: Text("紹介"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IntroductionPage(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_email),
            title: Text("ご意見、ご要望"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormPage(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(Icons.app_settings_alt),
            title: Text("環境設定"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
