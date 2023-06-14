import 'package:flutter/material.dart';
import 'package:flutter_practice/pages/frame.dart';
import 'package:flutter_practice/pages/game.dart';
import 'package:flutter_practice/pages/webview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> TitleData = [
    '전자액자',
    '나무위키',
    '미니게임',
  ];

  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
            children: [
              Frame(),
              Webview(),
              Game()
            ],
        ),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (value){
          setState(() {
            _selectedIndex = value;
          });
          print("value : ${value}");
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.picture_in_picture),
              label: TitleData[0],
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: TitleData[1],
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.videogame_asset),
              label: TitleData[2],
          )
        ],
      );
  }
}
