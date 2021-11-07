import 'package:flutter/material.dart';
import 'package:hobby/editprofile/editprofile_page.dart';
import 'package:hobby/myprofile/myprofile_model.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (_) => MyModel()..fetchUser(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            '私',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            Consumer<MyModel>(builder: (context, model, child) {
              return IconButton(
                onPressed: () async {
                  // 画面遷移
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(),
                    ),
                  );
                  model.fetchUser();
                },
                icon: Icon(Icons.edit),
              );
            }),
          ],
        ),
        body: Column(
          children: [
            Center(
              child: Consumer<MyModel>(builder: (context, model, child) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            model.name ?? '名前なし',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(model.email ?? 'メールアドレスなし'),
                          Text(
                            model.description ?? '自己紹介なし',
                          ),
                        ],
                      ),
                    ),
                    if (model.isLoading)
                      Container(
                        color: Colors.black54,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
