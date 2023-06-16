
import 'package:flutter/material.dart';
import 'package:journal/navigations/insight_view.dart';
import 'package:journal/navigations/media_view.dart';
import 'package:journal/navigations/new_note_view.dart';
import 'package:journal/navigations/settings_view.dart';
import 'package:journal/navigations/note_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List pages = [
    NoteView(),
    MediaView(),
    NewNoteView(),
    InsightView(),
    SettingView(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey.withOpacity(0.9),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            label: ('Home'),
            icon: Icon(Icons.article_outlined),
          ),
          BottomNavigationBarItem(
            label: ('Media'),
            icon: Icon(Icons.perm_media_sharp),
          ),
          BottomNavigationBarItem(
            label: ('New note'),
            icon: Icon(Icons.add_box_outlined),
          ),
          BottomNavigationBarItem(
            label: ('Insight'),
            icon: Icon(Icons.insights),
          ),
          BottomNavigationBarItem(
            label: ('Settings'),
            icon: Icon(Icons.person),
          )
        ],
      ),
    );
  }
}
