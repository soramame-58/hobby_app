import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage();
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: Text(
            "お話",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.photo_outlined),
              color: Colors.black,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.mic),
              color: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemCount: 1,
                  itemBuilder: (_, int index) {
                    return Container(
                      margin: EdgeInsets.only(
                          bottom: 20.0, right: 10.0, left: 10.0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              controller: _controller,
                              onSubmitted: _handleSubmit,
                              decoration: InputDecoration.collapsed(
                                  hintText: "メッセージの送信"),
                            ),
                          ),
                          Container(
                            child: IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  _handleSubmit(_controller.text);
                                }),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Divider(height: 1.0),
            ],
          ),
        ));
  }

  _handleSubmit(String message) {
    _controller.text = "";
    print(message);
  }
}
