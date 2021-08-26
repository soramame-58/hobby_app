import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'お話',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Container(
              height: 68,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt_outlined),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_outlined),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  )),
                  IconButton(
                    icon: Icon(Icons.photo_outlined),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
