import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/pages/02_map/page_map.dart';
import 'package:dongnesosik/pages/03_post/page_post.dart';
import 'package:dongnesosik/pages/04_user_setting/page_user_setting.dart';
import 'package:flutter/material.dart';

class PageTabs extends StatefulWidget {
  @override
  _PageTabsState createState() => _PageTabsState();
}

class _PageTabsState extends State<PageTabs> {
  int _selectedIndex = 0;

  List _pages = [
    PageMap(),
    // PagePost(),
    PageUserSetting(),
  ];

  List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: "지도"),
    // BottomNavigationBarItem(
    //     icon: Icon(Icons.sticky_note_2_outlined), label: "동내 게시판"),
    BottomNavigationBarItem(
        icon: Icon(Icons.admin_panel_settings), label: "내정보"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          print("You can not get out of here! kkk");
        });
        return Future(() => false);
      },
      child: Scaffold(
        body: _body(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: _items,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedItemColor: DSColors.tomato,
          unselectedItemColor: DSColors.gray3,
          showUnselectedLabels: true,
          // type: BottomNavigationBarType.fixed,
          // unselectedLabelColor: CDColors.gray6,
          // labelColor: CDColors.primary,
          // indicatorColor: CDColors.primary,
        ),
        // Theme(
        //   data: Theme.of(context).copyWith(
        //       canvasColor: Colors.white,
        //       primaryColor: JColors.tomato,
        //       textTheme: Theme.of(context).textTheme.copyWith(
        //           caption: new TextStyle(color: Colors.grey))), // sets the
        //   child:
        // ),
        // ),
      ),
    );
  }

  Widget _body() {
    return _pages[_selectedIndex];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
