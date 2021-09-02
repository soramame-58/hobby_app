import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  List<bool> _selections = List.generate(2, (_) => false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: ListView(children: <Widget>[
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
            ))
      ]),
    ));
  }
}
