import 'package:flutter/material.dart';
import 'package:hobby/camera/camera_page.dart';
import 'package:hobby/chat/chat_page.dart';

class CosmeticsPage extends StatefulWidget {
  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CosmeticsPage> {
  List<bool> _selections = List.generate(2, (_) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'コスメ',
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
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              child: ToggleButtons(
                children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.wc),
                ],
                isSelected: _selections,
                color: Colors.grey,
                selectedColor: Colors.white,
                fillColor: Colors.green,
                onPressed: (int index) {
                  setState(() {
                    _selections[index] = !_selections[index];
                  });
                },
              )),
        ],
      ),
    );
  }
}
