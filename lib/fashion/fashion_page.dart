import 'package:flutter/material.dart';
import 'package:hobby/camera/camera_page.dart';
import 'package:hobby/chat/chat_page.dart';

class FashionPage extends StatefulWidget {
  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<FashionPage> {
  List<bool> _selections = List.generate(2, (_) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '衣服',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt_outlined),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraPage(),
                  ));
            },
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(),
                  ));
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  child: ToggleButtons(
                    children: <Widget>[
                      Icon(Icons.favorite),
                      Icon(Icons.wc),
                    ],
                    color: Colors.grey,
                    selectedColor: Colors.white,
                    fillColor: Colors.green,
                    onPressed: (int index) {
                      setState(() {
                        if (index == 0) {
                          _selections[index] = !_selections[index];
                          print('ハート');
                          favorite_showDialog(context, '気になった投稿に追加しました');
                        } else if (index == 1) {
                          _selections[index] = !_selections[index];
                          print('友達');
                          wc_showDialog(context, '魅力的な人に追加しました');
                        }
                      });
                    },
                    isSelected: _selections,
                  ),
                )),
          ),
          Center(
              child: TextButton(
            child: Text(
              '前のページに戻るよ',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ))
        ],
      ),
    );
  }

  Future favorite_showDialog(
    BuildContext context,
    String title,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future wc_showDialog(
    BuildContext context,
    String title,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
