import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home/home_page.dart';
import 'setting/setting_page.dart';

//ホームと設定をボトムナビゲーションバーで分けている
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HobbyApp());
}

class HobbyApp extends StatefulWidget {
  @override
  _HobbyAppState createState() => _HobbyAppState();
}

class _HobbyAppState extends State<HobbyApp> {
  int selectedIndex = 0;

  List<Widget> widgetList = [
    HomePage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: widgetList[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.lightGreen,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定')
          ],
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
