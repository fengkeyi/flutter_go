import 'package:flutter/material.dart';
import 'package:flutter_go/chapter5/pages/navigationbar_my_page.dart';
import 'package:flutter_go/chapter5/pages/navigationbar_search_page.dart';
import 'package:flutter_go/chapter5/pages/navigationbar_travel_page.dart';
import 'package:flutter_go/chapter5/pages/navigationbar_home_page.dart';

class NavigationBarPage extends StatefulWidget {

  @override
  _NavigationBarPageState createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {

  PageController _pageController;
  int _currentIndex = 1;


  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  _buildBottomBarItem(IconData icon,String title){
    return BottomNavigationBarItem(icon: Icon(icon,),
      title: Text(title),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        children: <Widget>[
          NavigationBarHomePage(),
          NavigationBarSearchPage(),
          NavigationBarTravelPage(),
          NavigationBarMyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (currentIndex){
            _pageController.jumpToPage(currentIndex);
            setState(() {
              _currentIndex = currentIndex;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
        _buildBottomBarItem(Icons.home,'首页'),
        _buildBottomBarItem(Icons.search,'搜索'),
        _buildBottomBarItem(Icons.camera_alt,'旅拍'),
        _buildBottomBarItem(Icons.people,'我的'),
      ]),
    );
  }
}

