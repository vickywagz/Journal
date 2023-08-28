import 'package:flutter/material.dart';
import 'package:journal/screens/insight_view.dart';
import 'package:journal/screens/media_view.dart';
import 'package:journal/screens/new_note_view.dart';
import 'package:journal/screens/settings_view.dart';
import 'package:journal/screens/note_view.dart';

class NavigatorView extends StatefulWidget {
  const NavigatorView({super.key});

  @override
  State<NavigatorView> createState() => _NavigatorViewState();
}

class _NavigatorViewState extends State<NavigatorView> {
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
