import 'package:flutter/material.dart';
import 'package:hobby/signup_page.dart';

class SignUp extends StatelessWidget {
  @override
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '新規画面登録',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                child: Text(
                  '新規登録',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ));
                }),
            TextButton(
                child: Text(
                  'ログイン',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ));
                })
          ],
        ),
      ),
    );
  }
}
