import 'package:church_locator/screens/add_church_screen.dart';
import 'package:church_locator/screens/front_screen.dart';
import 'package:church_locator/screens/login_screen.dart';
import 'package:church_locator/screens/new_home_page.dart';
import 'package:church_locator/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class MyHomePageScreen extends StatefulWidget {
  static const String routeName = '/myhomePageScreen';
  @override
  _MyHomePageScreenState createState() => _MyHomePageScreenState();
}

class _MyHomePageScreenState extends State<MyHomePageScreen> {
  final List<Widget> _pages = [
    NewHomePage(),
    LoginScreen(),
    AddChurchScreen(),
    ProfileScreen()
  ];
  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            title: Text(""),
            icon: Image(
              image: AssetImage('assets/images/churchlocator.png'),
              width: 30.0,
              height: 30.0,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(""),
            icon: Image(
              image: AssetImage('assets/images/filter.png'),
              width: 30.0,
              height: 30.0,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(""),
            icon: Image(
              image: AssetImage('assets/images/addchurch.png'),
              width: 30.0,
              height: 30.0,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(""),
            icon: Image(
              image: AssetImage('assets/images/signup.png'),
              width: 30.0,
              height: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
