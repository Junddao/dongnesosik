import 'package:dongnesosik/global/style/jcolors.dart';
import 'package:dongnesosik/pages/02_map/page_map.dart';
import 'package:dongnesosik/pages/03_chat/page_chat.dart';
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
    PageChat(),
    PageUserSetting(),
  ];

  List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: "지도"),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: "메세지"),
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
    return Scaffold(
      body: _body(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Color(0xFF343C46),
          primaryColor: Colors.red,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: _items,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedItemColor: Colors.white,
          unselectedItemColor: JColors.gray2,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          // unselectedLabelColor: CDColors.gray6,
          // labelColor: CDColors.primary,
          // indicatorColor: CDColors.primary,
        ),
      ),
      // ),
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
