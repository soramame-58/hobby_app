import 'package:flutter/material.dart';
import 'package:hobby/curious/curious_page.dart';
import 'package:hobby/form/form_page.dart';
import 'package:hobby/introduction/introduction_page.dart';
import 'package:hobby/myprofile/myprofile_model.dart';
import 'package:hobby/myprofile/myprofile_page.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (_) => MyModel(),
      child: Scaffold(
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
              leading: Icon(Icons.hail),
              title: Text("プロフィールの表示"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyPage(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.wc),
              title: Text("魅力的な人達"),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("気になった投稿"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CuriousPage(),
                    ));
              },
            ),
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
            Consumer<MyModel>(builder: (context, model, child) {
              return ListTile(
                leading: Icon(Icons.warning_amber_outlined),
                title: Text("ログアウト"),
                onTap: () async {
                  await model.logout();
                  Navigator.of(context).pop();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
