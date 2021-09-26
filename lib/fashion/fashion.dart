// import 'package:flutter/material.dart';
// import 'package:hobby/camera/camera_page.dart';
// import 'package:hobby/chat/chat_page.dart';
// import 'package:hobby/fashion/fashion_model.dart';
// import 'package:hobby/hobby.dart';
// import 'package:provider/provider.dart';
//
// class FashionPage extends StatelessWidget {
//   final _controller = TextEditingController();
//
//   List<bool> _selections = List.generate(2, (index) => false);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<FashionModel>(
//       create: (_) => FashionModel(),
//       child: Scaffold(
//         appBar: AppBar(
//           iconTheme: IconThemeData(
//             color: Colors.black,
//           ),
//           backgroundColor: Colors.white,
//           centerTitle: true,
//           title: Text(
//             '衣服',
//             style: TextStyle(
//               color: Colors.black,
//             ),
//           ),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.camera_alt_outlined),
//               tooltip: '画像を投稿する',
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CameraPage(),
//                     ));
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.chat_bubble_outline),
//               tooltip: '好きを共有する',
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ChatPage(_controller.text),
//                     ));
//               },
//             ),
//           ],
//         ),
//         body: ListView(
//           children: [
//             Consumer<FashionModel>(builder: (context, model, child) {
//               final List<Hobby>? hobbys = model.hobbys;
//               Container(
//                 child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: ToggleButtons(
//                       children: <Widget>[
//                         Icon(Icons.favorite),
//                         Icon(Icons.wc),
//                       ],
//                       color: Colors.grey,
//                       selectedColor: Colors.white,
//                       fillColor: Colors.green,
//                       onPressed: (int index) {
//                         if (index == 0) {
//                           _selections[index] = !_selections[index];
//                           print('ハート');
//                           if (_selections[index]) {
//                             model.favorite_showDialog(context, '魅力的な人に追加しました');
//                           }
//                         } else if (index == 1) {
//                           _selections[index] = !_selections[index];
//                           print('友達');
//                           if (_selections[index]) {
//                             model.wc_showDialog(context, '気になった投稿に追加しました');
//                           }
//                         }
//                         ;
//                       },
//                       //どのボタンが選択されたかコントロールする
//                       isSelected: _selections,
//                     )),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// final List<Widget>? widgets = hobbys
//     .map(
//       (hobby) => GridView.builder(
//         itemCount: hobbys.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//         ),
//         itemBuilder: (context, index) {
//           return InkWell(
//             child: Container(
//               child: AspectRatio(
//                 aspectRatio: 1,
//                 child: Column(
//                   children: [
//                     Text('widgets'),
//                     Expanded(child: Image.network('widgets'))
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     )
//     .toList();
//
// body: Consumer<FashionModel>(builder: (context, model, child) {
// final List<Hobby>? hobbys = model.hobbys;
//
// if (hobbys == null) {
// return CircularProgressIndicator();
// }
// final List<Widget> widgets = hobbys
//     .map(
// (hobby) => Slidable(
// actionPane: SlidableDrawerActionPane(),
// child: ListTile(
// leading: hobby.imgURL != null
// ? Image.network(hobby.imgURL!)
//     : null,
// title: Text(hobby.title),
// ),
// secondaryActions: <Widget>[
// IconSlideAction(
// caption: '編集',
// color: Colors.black45,
// icon: Icons.edit,
// onTap: () async {
// // 編集画面に遷移
//
// // 画面遷移
// final String? title = await Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => EditHobbyPage(hobby),
// ),
// );
//
// if (title != null) {
// final snackBar = SnackBar(
// backgroundColor: Colors.green,
// content: Text('$titleを編集しました'),
// );
// ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }
// model.fetchFashionList();
// },
// ),
// ],
// ),
// )
//     .toList();
// return ListView(
// children: widgets,
// );
// }),
//
// Consumer<FashionModel>(builder: (context, model, child) {
//             return SingleChildScrollView(
//               child: Container(
//                 margin: const EdgeInsets.only(left: 45.0),
//                 child: ToggleButtons(
//                   children: <Widget>[
//                     Icon(Icons.favorite),
//                     Icon(Icons.wc),
//                   ],
//                   color: Colors.grey,
//                   selectedColor: Colors.white,
//                   fillColor: Colors.green,
//                   onPressed: (int index) {
//                     if (index == 0) {
//                       _selections[index] = !_selections[index];
//                       print('ハート');
//                       if (_selections[index]) {
//                         model.favorite_showDialog(context, '魅力的な人に追加しました');
//                       }
//                     } else if (index == 1) {
//                       _selections[index] = !_selections[index];
//                       print('友達');
//                       if (_selections[index]) {
//                         model.wc_showDialog(context, '気になった投稿に追加しました');
//                       }
//                     }
//                     ;
//                   },
//                   //どのボタンが選択されたかコントロールする
//                   isSelected: _selections,
//                 ),
//               ),
//             );
//           }),
