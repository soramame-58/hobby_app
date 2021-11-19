import 'package:flutter/material.dart';

class CuriousPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var listItem = [
      'one',
      'two',
      'three',
      'one',
      'one',
      'one',
      'one',
      'one',
      'one',
      'one',
      'one',
      'one',
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '魅力的な人たち',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black38),
                ),
              ),
              child: ListTile(
                leading: const Icon(Icons.face_outlined),
                title: Text('$index'),
                subtitle: Text(''),
                onTap: () {/* react to the tile being tapped */},
              ));
        },
        itemCount: listItem.length,
      ),
    );
  }
}
